import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../widgets/cart_body.dart';
import 'cart_notifier.dart';

class RiverpodCartPage extends ConsumerStatefulWidget {
  const RiverpodCartPage({super.key});
  @override
  ConsumerState<RiverpodCartPage> createState() => _RiverpodCartPageState();
}

class _RiverpodCartPageState extends ConsumerState<RiverpodCartPage> {
  final _couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listenManual(
      cartProvider.select((s) => s.checkoutStatus),
      (prev, next) {
        if (next == CheckoutStatus.success) {
          final orderId = ref.read(cartProvider).orderId;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed: $orderId')),
          );
        } else if (next == CheckoutStatus.failure) {
          final error = ref.read(cartProvider).checkoutError;
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(error ?? 'Checkout failed'),
              actions: [
                TextButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cartProvider);
    final cart = ref.read(cartProvider.notifier);
    final canUndo = ref.watch(canUndoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart · Riverpod'),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: canUndo ? cart.undo : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CartBody(
              lines: state.lines,
              onAdd: cart.add,
              onRemove: cart.remove,
              onQtyChanged: cart.changeQty,
            ),
          ),
          _RiverpodSummaryCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: InputDecoration(
                      labelText: 'Coupon code',
                      errorText: state.couponError,
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () =>
                      cart.applyCoupon(_couponController.text.trim()),
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: state.checkoutStatus == CheckoutStatus.submitting ||
                        state.lines.isEmpty
                    ? null
                    : cart.checkout,
                child: state.checkoutStatus == CheckoutStatus.submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Checkout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiverpodSummaryCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartProvider);
    debugPrint('SummaryCard rebuild — total: ${state.total}');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _row('Items', '${state.itemCount}'),
            _row('Subtotal', state.lines.subtotal.toStringAsFixed(2)),
            if (state.discount > 0)
              _row('Discount', '-${state.discount.toStringAsFixed(2)}'),
            const Divider(),
            _row('Total', state.total.toStringAsFixed(2), bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value,
              style: bold ? const TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      );
}
