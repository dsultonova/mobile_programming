import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../services/checkout_api.dart';
import '../widgets/cart_body.dart';

class SetStateCartPage extends StatefulWidget {
  const SetStateCartPage({super.key});
  @override
  State<SetStateCartPage> createState() => _SetStateCartPageState();
}

class _SetStateCartPageState extends State<SetStateCartPage> {
  CartState _state = const CartState();
  final List<CartState> _history = [];
  final _api = CheckoutApi();
  final _couponController = TextEditingController();

  void _pushHistory() => _history.add(_state);

  void _add(Product p) {
    _pushHistory();
    setState(() => _state = _state.copyWith(lines: _state.lines.withProduct(p)));
  }

  void _remove(String id) {
    _pushHistory();
    setState(() => _state = _state.copyWith(lines: _state.lines.without(id)));
  }

  void _changeQty(String id, int delta) {
    _pushHistory();
    setState(
        () => _state = _state.copyWith(lines: _state.lines.changeQty(id, delta)));
  }

  void _applyCoupon() {
    _pushHistory();
    final code = _couponController.text.trim();
    if (code == 'SAVE10') {
      setState(() => _state = _state.copyWith(
            coupon: () => code,
            couponError: () => null,
          ));
    } else {
      setState(() => _state = _state.copyWith(
            coupon: () => null,
            couponError: () => 'Invalid coupon code',
          ));
    }
  }

  Future<void> _checkout() async {
    setState(() => _state =
        _state.copyWith(checkoutStatus: CheckoutStatus.submitting));
    try {
      final orderId = await _api.submit(_state.total);
      if (!mounted) return;
      setState(() => _state = const CartState().copyWith(
            checkoutStatus: CheckoutStatus.success,
            orderId: () => orderId,
          ));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order placed: $orderId')),
        );
      }
    } on CheckoutException catch (e) {
      if (!mounted) return;
      setState(() => _state = _state.copyWith(
            checkoutStatus: CheckoutStatus.failure,
            checkoutError: () => e.message,
          ));
      if (mounted) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(e.message),
            actions: [
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context)
                    .hideCurrentMaterialBanner(),
                child: const Text('DISMISS'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() => _state = _history.removeLast());
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Cart · setState'),
          actions: [
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: _history.isEmpty ? null : _undo,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CartBody(
                lines: _state.lines,
                onAdd: _add,
                onRemove: _remove,
                onQtyChanged: _changeQty,
              ),
            ),
            _SummaryCard(state: _state),
            _CouponField(
              controller: _couponController,
              error: _state.couponError,
              onApply: _applyCoupon,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _state.checkoutStatus == CheckoutStatus.submitting ||
                          _state.lines.isEmpty
                      ? null
                      : _checkout,
                  child: _state.checkoutStatus == CheckoutStatus.submitting
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.state});
  final CartState state;

  @override
  Widget build(BuildContext context) => Card(
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

class _CouponField extends StatelessWidget {
  const _CouponField({
    required this.controller,
    this.error,
    required this.onApply,
  });
  final TextEditingController controller;
  final String? error;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Coupon code',
                  errorText: error,
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(onPressed: onApply, child: const Text('Apply')),
          ],
        ),
      );
}
