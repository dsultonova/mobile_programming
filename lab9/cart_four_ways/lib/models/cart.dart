class Product {
  const Product({required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final double price;
}

const catalog = [
  Product(id: 'p1', name: 'Keyboard', price: 49),
  Product(id: 'p2', name: 'Mouse', price: 25),
  Product(id: 'p3', name: 'Monitor', price: 199),
];

class CartLine {
  const CartLine({required this.product, required this.qty});
  final Product product;
  final int qty;
  double get subtotal => product.price * qty;
  CartLine copyWith({int? qty}) =>
      CartLine(product: product, qty: qty ?? this.qty);
}

extension CartLines on List<CartLine> {
  List<CartLine> withProduct(Product p) {
    final i = indexWhere((l) => l.product.id == p.id);
    if (i == -1) return [...this, CartLine(product: p, qty: 1)];
    return [
      for (final l in this)
        l.product.id == p.id ? l.copyWith(qty: l.qty + 1) : l
    ];
  }

  List<CartLine> without(String productId) =>
      [for (final l in this) if (l.product.id != productId) l];

  List<CartLine> changeQty(String id, int delta) {
    return [
      for (final l in this)
        if (l.product.id == id)
          if (l.qty + delta <= 0)
            ...[] // remove line
          else
            l.copyWith(qty: l.qty + delta)
        else
          l,
    ];
  }

  double get subtotal => fold(0.0, (s, l) => s + l.subtotal);
  int get itemCount => fold(0, (s, l) => s + l.qty);
}

enum CheckoutStatus { idle, submitting, success, failure }

class CartState {
  const CartState({
    this.lines = const [],
    this.coupon,
    this.couponError,
    this.checkoutStatus = CheckoutStatus.idle,
    this.orderId,
    this.checkoutError,
  });

  final List<CartLine> lines;
  final String? coupon;
  final String? couponError;
  final CheckoutStatus checkoutStatus;
  final String? orderId;
  final String? checkoutError;

  double get discount =>
      coupon == 'SAVE10' ? lines.subtotal * 0.1 : 0;
  double get total => lines.subtotal - discount;
  int get itemCount => lines.itemCount;

  CartState copyWith({
    List<CartLine>? lines,
    String? Function()? coupon,
    String? Function()? couponError,
    CheckoutStatus? checkoutStatus,
    String? Function()? orderId,
    String? Function()? checkoutError,
  }) {
    return CartState(
      lines: lines ?? this.lines,
      coupon: coupon != null ? coupon() : this.coupon,
      couponError: couponError != null ? couponError() : this.couponError,
      checkoutStatus: checkoutStatus ?? this.checkoutStatus,
      orderId: orderId != null ? orderId() : this.orderId,
      checkoutError: checkoutError != null ? checkoutError() : this.checkoutError,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartState &&
          runtimeType == other.runtimeType &&
          _listEquals(lines, other.lines) &&
          coupon == other.coupon &&
          couponError == other.couponError &&
          checkoutStatus == other.checkoutStatus &&
          orderId == other.orderId &&
          checkoutError == other.checkoutError;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(lines.map((l) => Object.hash(l.product.id, l.qty))),
        coupon,
        couponError,
        checkoutStatus,
        orderId,
        checkoutError,
      );

  static bool _listEquals(List<CartLine> a, List<CartLine> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].product.id != b[i].product.id || a[i].qty != b[i].qty) {
        return false;
      }
    }
    return true;
  }
}
