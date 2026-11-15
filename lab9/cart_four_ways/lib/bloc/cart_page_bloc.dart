import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';

class BlocCartPage extends StatelessWidget {
  const BlocCartPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CartBloc(CheckoutApi()),
        child: const _BlocCartView(),
      );
}

class _BlocCartView extends StatefulWidget {
  const _BlocCartView();
  @override
  State<_BlocCartView> createState() => _BlocCartViewState();
}

class _BlocCartViewState extends State<_BlocCartView> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (p, c) => p.checkoutStatus != c.checkoutStatus,
      listener: (context, state) {
        if (state.checkoutStatus == CheckoutStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order placed: ${state.orderId}')),
          );
        } else if (state.checkoutStatus == CheckoutStatus.failure) {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text(state.checkoutError ?? 'Checkout failed'),
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
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final bloc = context.read<CartBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart · Bloc'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed:
                      bloc.canUndo ? () => bloc.add(const CartUndone()) : null,
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: CartBody(
                    lines: state.lines,
                    onAdd: (p) => bloc.add(CartProductAdded(p)),
                    onRemove: (id) => bloc.add(CartProductRemoved(id)),
                    onQtyChanged: (id, delta) =>
                        bloc.add(CartQtyChanged(id, delta)),
                  ),
                ),
                BlocSelector<CartBloc, CartState, double>(
                  selector: (state) => state.total,
                  builder: (context, total) {
                    final s = context.read<CartBloc>().state;
                    debugPrint('Bloc SummaryCard rebuild — total: $total');
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _row('Items', '${s.itemCount}'),
                            _row('Subtotal',
                                s.lines.subtotal.toStringAsFixed(2)),
                            if (s.discount > 0)
                              _row('Discount',
                                  '-${s.discount.toStringAsFixed(2)}'),
                            const Divider(),
                            _row('Total', s.total.toStringAsFixed(2),
                                bold: true),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                        onPressed: () => bloc.add(
                            CartCouponApplied(_couponController.text.trim())),
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
                      onPressed: state.checkoutStatus ==
                                  CheckoutStatus.submitting ||
                              state.lines.isEmpty
                          ? null
                          : () => bloc.add(const CartCheckoutRequested()),
                      child:
                          state.checkoutStatus == CheckoutStatus.submitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : const Text('Checkout'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
