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


      final userName = CacheHelper.getData(key: _kUserNameDisplay) as String? ?? 'User';

      emit(HomeLoaded(
        products: products,
        categories: categories,
        brands: brands,
        userName: userName,
      ));
    } catch (e) {
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }



  Future<List<ProductsModel>> _fetchProducts() async {
    final response = await api.get(Endpoint.proudacts);
    final List jsonBody = response['products'] ?? response['data']?['list'] ?? [];
    return jsonBody.map((e) => ProductsModel.fromJson(e)).toList();
  }

  Future<List<CategoriesModel>> _fetchCategories() async {
    final response = await api.get(Endpoint.categories);
    final List jsonBody = response['data']?['list'] ?? [];
    return jsonBody.map((e) => CategoriesModel.fromJson(e)).toList();
  }

  Future<List<Brand>> _fetchBrands() async {
    final response = await api.get(Endpoint.brands);
    final List jsonBody = response['data']?['list'] ?? [];
    return jsonBody.map((e) => Brand.fromJson(e)).toList();
  }
}
