import 'package:bloc_test/bloc_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:cart_four_ways/cubit/cart_cubit.dart';

class MockCheckoutApi extends Mock implements CheckoutApi {}

void main() {
  const keyboard = Product(id: 'p1', name: 'Keyboard', price: 49);

  blocTest<CartCubit, CartState>(
    'add Keyboard twice, apply SAVE10 — emits three states',
    build: () => CartCubit(MockCheckoutApi()),
    act: (c) {
      c.add(keyboard);
      c.add(keyboard);
      c.applyCoupon('SAVE10');
    },
    expect: () => [
      // After first add: 1 keyboard
      CartState(lines: const [CartLine(product: keyboard, qty: 1)]),
      // After second add: 2 keyboards
      CartState(lines: const [CartLine(product: keyboard, qty: 2)]),
      // After coupon: 2 keyboards + SAVE10
      CartState(
        lines: const [CartLine(product: keyboard, qty: 2)],
        coupon: 'SAVE10',
      ),
    ],
  );

  blocTest<CartCubit, CartState>(
    'checkout failure emits submitting then failure with lines intact',
    build: () {
      final mockApi = MockCheckoutApi();
      when(() => mockApi.submit(any()))
          .thenThrow(const CheckoutException('Card declined'));
      return CartCubit(mockApi);
    },
    seed: () => CartState(lines: const [CartLine(product: keyboard, qty: 2)]),
    act: (c) => c.checkout(),
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
}
