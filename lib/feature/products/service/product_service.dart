import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';

class ProductService {
  final ApiConsumer api;

  ProductService(this.api);

  Future<dynamic> fetchProductsResponse() async {
    return api.get(Endpoint.products);
  }

  Future<dynamic> fetchBrandsResponse() async {
    return api.get(Endpoint.brands);
  }

  Future<dynamic> fetchCategoriesResponse() async {
    return api.get(Endpoint.categories);
  }

  Future<List<ProductsModel>> getProducts() async {
    final response = await fetchProductsResponse();
    final list = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(ProductsModel.fromJson)
        .toList();
  }

  Future<List<Brand>> getBrands() async {
    final response = await fetchBrandsResponse();
    final list = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(Brand.fromJson)
        .toList();
  }

  Future<List<CategoriesModel>> getCategories() async {
    final response = await fetchCategoriesResponse();
    final list = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(CategoriesModel.fromJson)
        .toList();
  }
}
