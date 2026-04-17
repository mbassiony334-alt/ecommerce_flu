import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.api}) : super(CartInitial());
   final ApiConsumer api;
  Future<void> addCart(int id) async {
    emit(CartLoading());
    try {
      await api.post(
        Endpoint.addCart,
        data: {ApiKey.productId: id},
      );
      emit(CartSuccess());
    } on ServerError catch (e) {
      emit(CartFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final response = await api.get(Endpoint.getCart);
      final list = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
      final List<ProductsModel> carts = list
          .whereType<Map<String, dynamic>>()
          .map(ProductsModel.fromJson)
          .toList();
      emit(ListCartSuccess(car: carts));
    } on ServerError catch (e) {
      emit(CartFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(CartFailure(errorMessage: e.toString()));
    }
  }
  Future<void> delCart(int id) async {
    emit(CartLoading());
    try {
      await api.post(
        Endpoint.delCart,
        data: {ApiKey.productId: id},
      );
      emit(DelCartSuccess());
    } on ServerError catch (e) {
      emit(DelCartFaliure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(DelCartFaliure(errorMessage: e.toString()));
    }
  }
}
