import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit({required this.api}) : super(FavInitial());
  final ApiConsumer api;
  Future<void> addFavourite(int id) async {
    emit(FavLoading());
    try {
      await api.post(
        Endpoint.addFavourite,
        data: {ApiKey.productId: id},
      );
      emit(FavSuccess());
    } on ServerError catch (e) {
      emit(FavFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(FavFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getFavourite() async {
    emit(FavLoading());
    try {
      final response = await api.get(Endpoint.getFavourite);
      final list = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
      final List<ProductsModel> favourits = list
          .whereType<Map<String, dynamic>>()
          .map(ProductsModel.fromJson)
          .toList();
      emit(ListFavSuccess(faovourite: favourits));
    } on ServerError catch (e) {
      emit(FavFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(FavFailure(errorMessage: e.toString()));
    }
  }
  Future<void> delFavourite(int id) async {
    emit(FavLoading());
    try {
      await api.post(
        Endpoint.delFavourite,
        data: {ApiKey.productId: id},
      );
      emit(DelFavSuccess());
    } on ServerError catch (e) {
      emit(DelFavFaliure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(DelFavFaliure(errorMessage: e.toString()));
    }
  }
}

