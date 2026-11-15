import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';

class CartNotifier extends Notifier<CartState> {
  final List<CartState> _history = [];

  @override
  CartState build() => const CartState();

  void _pushHistory() => _history.add(state);

  void add(Product p) {
    _pushHistory();
    state = state.copyWith(lines: state.lines.withProduct(p));
  }

  void remove(String id) {
    _pushHistory();
    state = state.copyWith(lines: state.lines.without(id));
  }

  void changeQty(String id, int delta) {
    _pushHistory();
    state = state.copyWith(lines: state.lines.changeQty(id, delta));
  }

  void applyCoupon(String code) {
    _pushHistory();
    if (code == 'SAVE10') {
      state = state.copyWith(coupon: () => code, couponError: () => null);
    } else {
      state = state.copyWith(
          coupon: () => null, couponError: () => 'Invalid coupon code');
    }
  }

  Future<void> checkout() async {
    final api = ref.read(checkoutApiProvider);
    state = state.copyWith(checkoutStatus: CheckoutStatus.submitting);
    try {
      final orderId = await api.submit(state.total);
      state = const CartState().copyWith(
        checkoutStatus: CheckoutStatus.success,
        orderId: () => orderId,
      );
    } on CheckoutException catch (e) {
      state = state.copyWith(
        checkoutStatus: CheckoutStatus.failure,
        checkoutError: () => e.message,
      );
    }
  }

  bool get canUndo => _history.isNotEmpty;

  void undo() {
    if (_history.isEmpty) return;
    state = _history.removeLast();
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, CartState>(CartNotifier.new);

final canUndoProvider = Provider<bool>((ref) {
  ref.watch(cartProvider);
  return ref.read(cartProvider.notifier).canUndo;
});

final checkoutApiProvider = Provider<CheckoutApi>((ref) => CheckoutApi());
