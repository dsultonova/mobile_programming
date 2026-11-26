import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/product_api.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._api) : super(DetailsLoading());

  final ProductApi _api;

  Future<void> load(int id) async {
    emit(DetailsLoading());

    try {
      final product = await _api.getProduct(id);

      if (isClosed) return;

      emit(DetailsLoaded(product));
    } on ApiException catch (e) {
      if (!isClosed) {
        emit(DetailsError(e.message));
      }
    }
  }
}