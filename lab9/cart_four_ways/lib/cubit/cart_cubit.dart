import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._api) : super(const CartState());

  final CheckoutApi _api;
  final List<CartState> _history = [];

  void _pushHistory() => _history.add(state);

  void add(Product p) {
    _pushHistory();
    emit(state.copyWith(lines: state.lines.withProduct(p)));
  }

  void remove(String id) {
    _pushHistory();
    emit(state.copyWith(lines: state.lines.without(id)));
  }

  void changeQty(String id, int delta) {
    _pushHistory();
    emit(state.copyWith(lines: state.lines.changeQty(id, delta)));
  }

  void applyCoupon(String code) {
    _pushHistory();
    if (code == 'SAVE10') {
      emit(state.copyWith(coupon: () => code, couponError: () => null));
    } else {
      emit(state.copyWith(
          coupon: () => null, couponError: () => 'Invalid coupon code'));
    }
  }

  Future<void> checkout() async {
    emit(state.copyWith(checkoutStatus: CheckoutStatus.submitting));
    try {
      final orderId = await _api.submit(state.total);
      if (isClosed) return;
      emit(const CartState().copyWith(
        checkoutStatus: CheckoutStatus.success,
        orderId: () => orderId,
      ));
    } on CheckoutException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        checkoutStatus: CheckoutStatus.failure,
        checkoutError: () => e.message,
      ));
    }
  }

  bool get canUndo => _history.isNotEmpty;

  void undo() {
    if (_history.isEmpty) return;
    emit(_history.removeLast());
  }
}
