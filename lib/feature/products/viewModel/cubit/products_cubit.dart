import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.api}) : super(ProductsInitial());
  final ApiConsumer api;
  Future<void> getProudacts() async {
    emit(ProductsLoading());
    try {
      var response = await api.get(Endpoint.proudacts);
      List jsonbody = response.data["list"];
      List<ProductsModel> products = jsonbody
          .map((e) => ProductsModel.fromJson(e))
          .toList();
      emit(ProductSuccess(products: products));
    } on ServeEror catch (e) {
      emit(ProductsFaliure(errorMessage: e.erorrModel.errorMessage));
    }

  
  }

  Future<void> getONeProudact(int id) async {
    emit(ProductsLoading());
    try {
      var response = await api.get("${Endpoint.proudacts}/$id");
      ProductsModel product = response.data;
     
      emit(SpecficProductSuccess(product: product, ));
    } on ServeEror catch (e) {
      emit(ProductsFaliure(errorMessage: e.erorrModel.errorMessage));
    }

  
  }
}
