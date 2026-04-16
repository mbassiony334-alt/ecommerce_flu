import 'package:bloc/bloc.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:meta/meta.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit({required this.api}) : super(BrandInitial());
  final ApiConsumer api;
  Future<void> getCategoriess() async {
    emit(BrandLoading());
    try {
      var response = await api.get(Endpoint.brands);
      List jsonbody = response.data["list"];
      List<Brand> brands = jsonbody.map((e) => Brand.fromJson(e)).toList();
      emit(BrandSuccess(brands: brands));
    } on ServeEror catch (e) {
      emit(BrandFaliure(errorMessage: e.erorrModel.errorMessage));
    }
  }
}
