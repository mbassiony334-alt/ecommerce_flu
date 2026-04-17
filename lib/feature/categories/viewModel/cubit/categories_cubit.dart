import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.api}) : super(CategoriesInitial());
  final ApiConsumer api;

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await api.get(Endpoint.categories);
      final List rawData = (response is Map<String, dynamic> ? response['data'] : null) as List? ?? const [];
      final List<CategoriesModel> categories = rawData
          .whereType<Map<String, dynamic>>()
          .map(CategoriesModel.fromJson)
          .toList();
      emit(CategoriesSuccess(categories: categories));
    } on ServerError catch (e) {
      emit(Categoriesfailure(message: e.errorModel.errorMessage));
    } catch (e) {
      emit(Categoriesfailure(message: e.toString()));
    }
  }
}
