import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/product_api.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._api) : super(ProductsLoading());

  final ProductApi _api;

  bool _isLoadingMore = false;

  Future<void> load() async {
    emit(ProductsLoading());

    try {
      final page = await _api.getProducts();

      if (isClosed) return;

      emit(
        ProductsLoaded(
          products: page.products,
          total: page.total,
        ),
      );
    } on ApiException catch (e) {
      if (!isClosed) {
        emit(ProductsError(e.message));
      }
    }
  }

  Future<void> loadMore() async {
    final currentState = state;

    if (currentState is! ProductsLoaded ||
        !currentState.hasMore ||
        _isLoadingMore) {
      return;
    }

    _isLoadingMore = true;

    try {
      final page = await _api.getProducts(
        skip: currentState.products.length,
      );

      if (isClosed) return;

      emit(
        ProductsLoaded(
          products: [...currentState.products, ...page.products],
          total: page.total,
        ),
      );
    } on ApiException catch (e) {
      if (!isClosed) {
        emit(ProductsError(e.message));
      }
    } finally {
      _isLoadingMore = false;
    }
  }
}