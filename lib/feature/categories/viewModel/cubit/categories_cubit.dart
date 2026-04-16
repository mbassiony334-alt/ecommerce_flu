import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/feature/categories/model/categoriesModel.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.api}) : super(CategoriesInitial());
  final ApiConsumer api;
  Future<void> getCategoriess() async {
    emit(CategoriesLoading());
    try {
      var response = await api.get(Endpoint.categories);
      List jsonbody = response.data["list"];
      List<CategoriesModel> categories = jsonbody
          .map((e) => CategoriesModel.fromJson(e))
          .toList();
      emit(CategoriesSuccess(categories: categories));
    } on ServeEror catch (e) {
      emit(Categoriesfailure(message: e.erorrModel.errorMessage));
    }
  }
}
