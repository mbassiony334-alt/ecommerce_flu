import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required this.api}) : super(ProductsInitial());
  final ApiConsumer api;

  Map<String, dynamic>? _asMap(dynamic response) {
    final dynamic data = response is Response ? response.data : response;
    return data is Map<String, dynamic> ? data : null;
  }

  List<Map<String, dynamic>> _extractData(dynamic response) {
    final map = _asMap(response);
    final list = (map?['data']) as List? ?? const [];
    return list.whereType<Map<String, dynamic>>().toList();
  }

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      final response = await api.get(Endpoint.products);
      final rawData = _extractData(response);
      final List<ProductsModel> products = rawData.map(ProductsModel.fromJson).toList();
      emit(ProductSuccess(products: products));
    } on ServerError catch (e) {
      emit(ProductsFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(ProductsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getOneProduct(int id) async {
    emit(ProductsLoading());
    try {
      
      
      final path = Endpoint.products.split('?').first;
      final response = await api.get("$path/$id");
      
      if (response == null) {
        emit(ProductsFailure(errorMessage: 'Product not found'));
        return;
      }

      final map = _asMap(response) ?? <String, dynamic>{};
      final data = map['data'];
      final productMap = data is Map<String, dynamic> ? data : map;
      final ProductsModel product = ProductsModel.fromJson(productMap);
      emit(SpecificProductSuccess(product: product));
    } on ServerError catch (e) {
      emit(ProductsFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(ProductsFailure(errorMessage: e.toString()));
    }
  }
}
