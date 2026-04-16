import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit({required this.api}) : super(FavInitial());
  final ApiConsumer api;
  Future<void> addFavourite(int id) async {
    emit(FavLoading());
    try {
      var response = await api.post(
        Endpoint.addfavourite,
        data: {ApiKey.productId: id},
      );
      print(response);
      emit(FavSuccess());
    } on ServeEror catch (e) {
      emit(FavFailure(errorMessage: e.erorrModel.errorMessage));
    }
  }

  Future<void> getFavourite() async {
    emit(FavLoading());
    try {
      var response = await api.get(Endpoint.getfavourite);
      List jsonbody = response.data["list"];
      List<ProductsModel> favourits = jsonbody
          .map((e) => ProductsModel.fromJson(e))
          .toList();
      emit(ListFavSuccess(faovourite: favourits));
    } on ServeEror catch (e) {
      emit(FavFailure(errorMessage: e.erorrModel.errorMessage));
    }
  }
  Future<void> delFavourite(int id) async {
    emit(FavLoading());
    try {
      var response = await api.post(
        Endpoint.delfavourite,
        data: {ApiKey.productId: id},
      );
      print(response);
      emit(DelFavSuccess());
    } on ServeEror catch (e) {
      emit(DelFavFaliure(errorMessage: e.erorrModel.errorMessage));
    }
  }
}

