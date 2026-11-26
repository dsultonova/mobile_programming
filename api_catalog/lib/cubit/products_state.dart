import '../models/product.dart';

sealed class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsError extends ProductsState {
  ProductsError(this.message);

  final String message;
}

class ProductsLoaded extends ProductsState {
  ProductsLoaded({
    required this.products,
    required this.total,
  });

  final List<Product> products;
  final int total;

  bool get hasMore => products.length < total;
}