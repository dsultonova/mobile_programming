import '../models/product.dart';

sealed class DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsError extends DetailsState {
  DetailsError(this.message);

  final String message;
}

class DetailsLoaded extends DetailsState {
  DetailsLoaded(this.product);

  final Product product;
}