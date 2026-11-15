import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';
import 'cart_cubit.dart';

class CubitCartPage extends StatelessWidget {
  const CubitCartPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CartCubit(CheckoutApi()),
        child: const _CubitCartView(),
      );
}

class _CubitCartView extends StatefulWidget {
  const _CubitCartView();
  @override
  State<_CubitCartView> createState() => _CubitCartViewState();
}

class _CubitCartViewState extends State<_CubitCartView> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
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
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cart · Cubit'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: cubit.canUndo ? cubit.undo : null,
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: CartBody(
                    lines: state.lines,
                    onAdd: cubit.add,
                    onRemove: cubit.remove,
                    onQtyChanged: cubit.changeQty,
                  ),
                ),
                BlocSelector<CartCubit, CartState, double>(
                  selector: (state) => state.total,
                  builder: (context, total) {
                    final s = context.read<CartCubit>().state;
                    debugPrint('Cubit SummaryCard rebuild — total: $total');
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
                        onPressed: () =>
                            cubit.applyCoupon(_couponController.text.trim()),
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
                          : cubit.checkout,
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
