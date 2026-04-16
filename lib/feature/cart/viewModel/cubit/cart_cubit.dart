import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.api}) : super(CartInitial());
   final ApiConsumer api;
  Future<void> addCart(int id) async {
    emit(CartLoading());
    try {
      var response = await api.post(
        Endpoint.addCart,
        data: {ApiKey.productId: id},
      );
      print(response);
      emit(CartSuccess());
    } on ServeEror catch (e) {
      emit(CartFailure(errorMessage: e.erorrModel.errorMessage));
    }
  }

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      var response = await api.get(Endpoint.getCart);
      List jsonbody = response.data["list"];
      List<ProductsModel> carts = jsonbody
          .map((e) => ProductsModel.fromJson(e))
          .toList();
      emit(ListCartSuccess(car: carts));
    } on ServeEror catch (e) {
      emit(CartFailure(errorMessage: e.erorrModel.errorMessage));
    }
  }
  Future<void> delCart(int id) async {
    emit(CartLoading());
    try {
      var response = await api.post(
        Endpoint.delCart,
        data: {ApiKey.productId: id},
      );
      print(response);
      emit(DelCartSuccess());
    } on ServeEror catch (e) {
      emit(DelCartFaliure(errorMessage: e.erorrModel.errorMessage));
    }
  }
}
