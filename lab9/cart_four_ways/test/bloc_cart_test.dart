import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:cart_four_ways/bloc/cart_bloc.dart';
import 'package:cart_four_ways/bloc/cart_event.dart';

class MockCheckoutApi extends Mock implements CheckoutApi {}

void main() {
  const keyboard = Product(id: 'p1', name: 'Keyboard', price: 49);

  blocTest<CartBloc, CartState>(
    'add Keyboard twice, apply SAVE10 — emits three states',
    build: () => CartBloc(MockCheckoutApi()),
    act: (b) => b
      ..add(const CartProductAdded(keyboard))
      ..add(const CartProductAdded(keyboard))
      ..add(const CartCouponApplied('SAVE10')),
    expect: () => [
      CartState(lines: const [CartLine(product: keyboard, qty: 1)]),
      CartState(lines: const [CartLine(product: keyboard, qty: 2)]),
      CartState(
        lines: const [CartLine(product: keyboard, qty: 2)],
        coupon: 'SAVE10',
      ),
    ],
  );

  blocTest<CartBloc, CartState>(
    'checkout failure emits submitting then failure with lines intact',
    build: () {
      final mockApi = MockCheckoutApi();
      when(() => mockApi.submit(any()))
          .thenThrow(const CheckoutException('Card declined'));
      return CartBloc(mockApi);
    },
    seed: () => CartState(lines: const [CartLine(product: keyboard, qty: 2)]),
    act: (b) => b.add(const CartCheckoutRequested()),
    expect: () => [
      CartState(
        lines: const [CartLine(product: keyboard, qty: 2)],
        checkoutStatus: CheckoutStatus.submitting,
      ),
      CartState(
        lines: const [CartLine(product: keyboard, qty: 2)],
        checkoutStatus: CheckoutStatus.failure,
        checkoutError: 'Card declined',
      ),
    ],
  );

  blocTest<CartBloc, CartState>(
    'duplicate checkout requests are handled sequentially',
    build: () {
      final mockApi = MockCheckoutApi();
      when(() => mockApi.submit(any()))
          .thenAnswer((_) async => 'ORD-0001');
      return CartBloc(mockApi);
    },
    seed: () => CartState(lines: const [CartLine(product: keyboard, qty: 1)]),
    act: (b) {
      b.add(const CartCheckoutRequested());
      b.add(const CartCheckoutRequested());
    },
    wait: const Duration(seconds: 4),
    expect: () => [
      CartState(
        lines: const [CartLine(product: keyboard, qty: 1)],
        checkoutStatus: CheckoutStatus.submitting,
      ),
      const CartState(
        checkoutStatus: CheckoutStatus.success,
        orderId: 'ORD-0001',
      ),
      const CartState(
        checkoutStatus: CheckoutStatus.submitting,
        orderId: 'ORD-0001',
      ),
      const CartState(
        checkoutStatus: CheckoutStatus.success,
        orderId: 'ORD-0001',
      ),
    ],
  );
}
