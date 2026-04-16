import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/core/services/cash/cash_Healper.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:e_commarcae/feature/products/model/productsModel.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.api}) : super(HomeInitial());

  final ApiConsumer api;


  static const String _kUserNameDisplay = 'userName';




  Future<void> loadHome() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        _fetchProducts(),
        _fetchCategories(),
        _fetchBrands(),
      ]);

      final products = results[0] as List<ProductsModel>;
      final categories = results[1] as List<CategoriesModel>;
      final brands = results[2] as List<Brand>;

      print('DEBUG: HomeLoaded - products: ${products.length}, cats: ${categories.length}, brands: ${brands.length}');

      final userName = CacheHelper.getData(key: _kUserNameDisplay) as String? ?? 'User';

      emit(HomeLoaded(
        products: products,
        categories: categories,
        brands: brands,
        userName: userName,
      ));
    } catch (e) {
      print('HomeCubit Error: $e');
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }

  Future<List<ProductsModel>> _fetchProducts() async {
    final response = await api.get(Endpoint.products);
    print('DEBUG: Products response: $response');
    if (response == null) return [];
    
    final List jsonBody = (response is List) ? response : 
                         (response['products'] ?? 
                         (response['data'] is Map ? response['data']['list'] : null) ?? 
                         (response['data'] is List ? response['data'] : null) ?? 
                         (response['results'] is List ? response['results'] : null) ?? 
                         []);
    return jsonBody.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>? ?? {})).toList();
  }

  Future<List<CategoriesModel>> _fetchCategories() async {
    final response = await api.get(Endpoint.categories);
    print('DEBUG: Categories response: $response');
    if (response == null) return [];

    final List jsonBody = (response is List) ? response : 
                         (response['categories'] ?? 
                         (response['data'] is Map ? response['data']['list'] : null) ?? 
                         (response['data'] is List ? response['data'] : null) ?? 
                         (response['results'] is List ? response['results'] : null) ?? 
                         []);
    return jsonBody.map((e) => CategoriesModel.fromJson(e as Map<String, dynamic>? ?? {})).toList();
  }

  Future<List<Brand>> _fetchBrands() async {
    final response = await api.get(Endpoint.brands);
    print('DEBUG: Brands response: $response');
    if (response == null) return [];

    final List jsonBody = (response is List) ? response : 
                         (response['brands'] ?? 
                         (response['data'] is Map ? response['data']['list'] : null) ?? 
                         (response['data'] is List ? response['data'] : null) ?? 
                         (response['results'] is List ? response['results'] : null) ?? 
                         []);
    return jsonBody.map((e) => Brand.fromJson(e as Map<String, dynamic>? ?? {})).toList();
  }
}
