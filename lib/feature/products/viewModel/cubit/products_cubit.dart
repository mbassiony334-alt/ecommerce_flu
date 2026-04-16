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
  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      final response = await api.get(Endpoint.products);
      if (response == null) {
        emit(ProductSuccess(products: const []));
        return;
      }
      
      final List jsonBody = response['products'] ?? 
                           (response['data'] is Map ? response['data']['list'] : null) ?? 
                           (response['data'] is List ? response['data'] : []) ?? 
                           [];
      
      final List<ProductsModel> products = jsonBody
          .map((e) => ProductsModel.fromJson(e))
          .toList();
      emit(ProductSuccess(products: products));
    } on ServeEror catch (e) {
      emit(ProductsFaliure(errorMessage: e.erorrModel.errorMessage));
    } catch (e) {
      emit(ProductsFaliure(errorMessage: e.toString()));
    }
  }

  Future<void> getOneProduct(int id) async {
    emit(ProductsLoading());
    try {
      // Typically single product endpoint doesn't have query params skip/limit
      // Constructing common REST path for single item
      final path = Endpoint.products.split('?').first;
      final response = await api.get("$path/$id");
      
      if (response == null) {
        emit(ProductsFaliure(errorMessage: 'Product not found'));
        return;
      }

      final ProductsModel product = ProductsModel.fromJson(response);
      emit(SpecficProductSuccess(product: product));
    } on ServeEror catch (e) {
      emit(ProductsFaliure(errorMessage: e.erorrModel.errorMessage));
    } catch (e) {
      emit(ProductsFaliure(errorMessage: e.toString()));
    }
  }
}
