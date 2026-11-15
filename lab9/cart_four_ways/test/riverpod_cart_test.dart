import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cart_four_ways/models/cart.dart';
import 'package:cart_four_ways/services/checkout_api.dart';
import 'package:cart_four_ways/riverpod/cart_notifier.dart';

class MockCheckoutApi extends Mock implements CheckoutApi {}

void main() {
  const keyboard = Product(id: 'p1', name: 'Keyboard', price: 49);

  test('add Keyboard twice, apply SAVE10, total is 88.2', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(cartProvider.notifier);
    notifier.add(keyboard);
    notifier.add(keyboard);
    notifier.applyCoupon('SAVE10');

    final state = container.read(cartProvider);
    expect(state.total, 88.2);
  });

  test('checkout failure keeps cart lines', () async {
    final mockApi = MockCheckoutApi();
    when(() => mockApi.submit(any()))
        .thenThrow(const CheckoutException('Card declined'));

    final container = ProviderContainer(
      overrides: [checkoutApiProvider.overrideWithValue(mockApi)],
    );
    addTearDown(container.dispose);

    final notifier = container.read(cartProvider.notifier);
    notifier.add(keyboard);
    notifier.add(keyboard);

    await notifier.checkout();

    final state = container.read(cartProvider);
    expect(state.checkoutStatus, CheckoutStatus.failure);
    expect(state.lines.length, 1); // one line with qty 2
    expect(state.lines.first.qty, 2);
  });
}
