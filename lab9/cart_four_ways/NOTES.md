# Lab 9 — One Cart, Four Ways: Notes

## Part 1 Inline Questions

### Why is CartLine immutable with a copyWith instead of a mutable qty field?
Immutability ensures that state changes are detectable by comparing old and new objects. Riverpod, Cubit and Bloc all rely on `==` to decide whether to notify listeners. If we mutated `qty` in place, the object identity and equality would not change, so the UI would never rebuild. The only style where mutation would "work" is `setState`, because `setState` always marks the element dirty regardless of what changed — but this is a trap: it hides the fact that your data contract is broken and would silently fail the moment you switch to any other approach.

### Why does CartBody take callbacks rather than importing a provider or a bloc directly?
It keeps the widget "dumb" — it has no knowledge of how state is managed. This means the exact same widget is reused across all four styles without modification. If CartBody imported a provider, it would be coupled to Riverpod and unusable in the setState or Bloc pages.

---

## Part 2 (setState) Questions

### After T4, how would a second page read the cart?
It couldn't — `_lines` lives in the `State` object scoped to `SetStateCartPage`. You'd need to lift the state up to a common ancestor (e.g., an `InheritedWidget` above both pages) or switch to a solution like Riverpod/Bloc where state lives outside the widget tree.

### After T5, where does _history live, and what happens to it on hot restart versus hot reload?
`_history` is a field on the `State` object. On **hot reload**, `State` is preserved (Flutter calls `reassemble`), so `_history` survives. On **hot restart**, the entire app is rebuilt from scratch, so `_history` is lost.

---

## Part 3 (Riverpod) Questions

### ref.read vs ref.watch usage:
- `ref.read(cartProvider.notifier)` — to get method handles for callbacks (no subscription needed)
- `ref.read(checkoutApiProvider)` — inside the notifier to get the API instance (one-off lookup)
- `ref.read(cartProvider)` — inside `ref.listen` callback to read current state after status change
- `ref.watch(cartProvider)` — in `build()` to subscribe and rebuild on any cart state change
- `ref.watch(canUndoProvider)` — in `build()` to rebuild the undo button when undo availability changes

### Why does the summary card in T3 rebuild less often?
With `ref.watch(cartProvider.select((s) => s.total))`, the widget only rebuilds when `total` changes. Typing in the coupon field changes `couponError` but not `total`, so the summary card is skipped. In `setState`, the entire `build()` re-runs on every change regardless.

---

## Part 4 (Cubit) Questions

### What would break if you put BlocProvider inside CartBody?
`context.read<CartCubit>()` must be called from a context *below* the `BlocProvider`. If `BlocProvider` were inside `CartBody`, the `CartBody`'s own `context` would be *above* the provider, so lookups would throw `ProviderNotFoundException`.

### Riverpod equivalents:
| Bloc/Cubit             | Riverpod                                          |
|------------------------|---------------------------------------------------|
| `BlocProvider`         | `ProviderScope` + provider declaration             |
| `BlocBuilder`          | `ref.watch(provider)` in `ConsumerWidget.build`    |
| `BlocListener`         | `ref.listen(provider, ...)`                        |
| `context.read`         | `ref.read`                                         |
| `buildWhen`            | `ref.watch(provider.select(...))`                  |

---

## Part 5 (Bloc) Questions

### When is the event layer worth its boilerplate?
**Worth it:** T4 (async checkout) — with Bloc you can add `transformer: droppable()` to `CartCheckoutRequested` declaratively, preventing duplicate submissions. Cubit requires a manual `if (state.checkoutStatus == submitting) return` guard.

**Pure overhead:** T1 (quantity stepper) — `CartQtyChanged(id, delta)` does exactly what `changeQty(id, delta)` does. The event adds a class and a handler for no benefit.

### Which styles let you implement "drop duplicate taps" declaratively?
Only **Bloc** — via `transformer: droppable()` on the event handler. In **Cubit/setState**, you check status manually. In **Riverpod**, you check `state.checkoutStatus == submitting` before proceeding.

---

## Checkpoint Questions

### 1. Where state lives and when it dies (one line each):
- **setState:** In the `State` object on the widget; dies when the widget is popped from the tree.
- **Riverpod:** In the `ProviderContainer` (root `ProviderScope`); dies when the container is disposed (app exit, or on pop if `autoDispose`).
- **Cubit:** In the `Cubit` instance owned by `BlocProvider`; dies when `BlocProvider` is removed from the tree (calls `close()`).
- **Bloc:** In the `Bloc` instance owned by `BlocProvider`; dies when `BlocProvider` is removed from the tree (calls `close()`).

### 2. Single public mutation API:
- **Riverpod Notifier:** `state = newValue` (assignment to `state` setter)
- **Cubit:** `emit(newState)`
- **Bloc:** `add(event)` — the bloc internally calls `emit` in handlers
- **setState** has none — it is `setState(() { ... })`, which is a Flutter framework method, not a state-management API.

### 3. Mapping ref.watch/read/listen to BlocBuilder/context.read/BlocListener:
| Riverpod          | Bloc/Cubit            | setState equivalent       |
|-------------------|-----------------------|---------------------------|
| `ref.watch`       | `BlocBuilder`         | The whole `build()` re-run|
| `ref.read`        | `context.read`        | Direct field access       |
| `ref.listen`      | `BlocListener`        | No equivalent (manual)    |

`setState` fits as the most primitive: it re-runs `build()` unconditionally, which is equivalent to a `ref.watch` / `BlocBuilder` with no filtering.

### 4. Why do they skip notifying when new == old, and what must you do to CartState?
Skipping prevents unnecessary rebuilds. If every assignment triggered a rebuild, typing the same coupon twice would cause wasted work. You must:
1. **Override `==`** so that two `CartState` instances with identical fields are considered equal.
2. **Override `hashCode`** consistently with `==`, so collections and caching behave correctly.

### 5. After the await in checkout, what guard does each style need?
- **setState:** `if (!mounted) return;` — the `State` object may have been disposed while awaiting.
- **Riverpod:** Nothing — the notifier outlives the widget; assigning `state` after the widget is gone is safe (no listeners, no crash).
- **Cubit:** `if (isClosed) return;` — calling `emit` after `close()` throws a `StateError`.
- **Bloc:** `if (emit.isDone) return;` — the scoped `Emitter` is marked done when the bloc is closed; calling it throws.

They differ because each manages the lifecycle differently: `setState` is tied to the widget tree, Riverpod is decoupled, and Bloc/Cubit have an explicit `close()` lifecycle.

---

## Comparison Table

| Aspect               | setState | Riverpod  | Cubit    | Bloc     |
|----------------------|----------|-----------|----------|----------|
| Lines (T1–T5 impl)  | ~90      | ~70       | ~65      | ~85      |
| Lines (test code)    | ~20      | ~35       | ~40      | ~55      |
| Number of files      | 1        | 2         | 2        | 3        |
| **Strength**         | Zero dependencies, simplest mental model | Selective rebuilds, testable without widgets, DI built in | Simpler than Bloc, same `emit` pattern, great test ergonomics with `blocTest` | Full traceability via events, `transformer` for concurrency control |
| **Weakness**         | State dies with page, no sharing, prop drilling, manual `mounted` guard | Requires `ProviderScope` wrapper, `ref.read` vs `ref.watch` confusion | `canUndo` getter not observable by `BlocBuilder` (must be in state) | Boilerplate: one class per event, verbose for simple mutations |
