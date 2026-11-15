import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._api) : super(const CartState()) {
    on<CartProductAdded>(_onProductAdded);
    on<CartProductRemoved>(_onProductRemoved);
    on<CartQtyChanged>(_onQtyChanged);
    on<CartCouponApplied>(_onCouponApplied);
    on<CartCheckoutRequested>(_onCheckoutRequested);
    on<CartUndone>(_onUndone);
  }

  final CheckoutApi _api;
  final List<CartState> _history = [];

  bool _isUndoableEvent(CartEvent event) => switch (event) {
        CartProductAdded() => true,
        CartProductRemoved() => true,
        CartQtyChanged() => true,
        CartCouponApplied() => true,
        CartCheckoutRequested() => false,
        CartUndone() => false,
      };

  void _pushHistory(CartEvent event) {
    if (_isUndoableEvent(event)) _history.add(state);
  }

  void _onProductAdded(CartProductAdded event, Emitter<CartState> emit) {
    _pushHistory(event);
    emit(state.copyWith(lines: state.lines.withProduct(event.product)));
  }

  void _onProductRemoved(CartProductRemoved event, Emitter<CartState> emit) {
    _pushHistory(event);
    emit(state.copyWith(lines: state.lines.without(event.productId)));
  }

  void _onQtyChanged(CartQtyChanged event, Emitter<CartState> emit) {
    _pushHistory(event);
    emit(state.copyWith(
        lines: state.lines.changeQty(event.productId, event.delta)));
  }

  void _onCouponApplied(CartCouponApplied event, Emitter<CartState> emit) {
    _pushHistory(event);
    if (event.code == 'SAVE10') {
      emit(state.copyWith(coupon: () => event.code, couponError: () => null));
    } else {
      emit(state.copyWith(
          coupon: () => null, couponError: () => 'Invalid coupon code'));
    }
  }

  Future<void> _onCheckoutRequested(
      CartCheckoutRequested event, Emitter<CartState> emit) async {
    emit(state.copyWith(checkoutStatus: CheckoutStatus.submitting));
    try {
      final orderId = await _api.submit(state.total);
      if (emit.isDone) return;
      emit(const CartState().copyWith(
        checkoutStatus: CheckoutStatus.success,
        orderId: () => orderId,
      ));
    } on CheckoutException catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        checkoutStatus: CheckoutStatus.failure,
        checkoutError: () => e.message,
      ));
    }
  }

  void _onUndone(CartUndone event, Emitter<CartState> emit) {
    if (_history.isEmpty) return;
    emit(_history.removeLast());
  }

  bool get canUndo => _history.isNotEmpty;
}
