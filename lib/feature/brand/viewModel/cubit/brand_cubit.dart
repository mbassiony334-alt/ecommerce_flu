import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/feature/brand/model/brandModel.dart';
import 'package:meta/meta.dart';

part 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  BrandCubit({required this.api}) : super(BrandInitial());
  final ApiConsumer api;

  Map<String, dynamic>? _asMap(dynamic response) {
    final dynamic data = response is Response ? response.data : response;
    return data is Map<String, dynamic> ? data : null;
  }

  Future<void> getCategories() async {
    emit(BrandLoading());
    try {
      final response = await api.get(Endpoint.brands);
      final map = _asMap(response);
      final List rawData = (map?['data']) as List? ?? const [];
      final List<Brand> brands = rawData
          .whereType<Map<String, dynamic>>()
          .map(Brand.fromJson)
          .toList();
      emit(BrandSuccess(brands: brands));
    } on ServerError catch (e) {
      emit(BrandFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(BrandFailure(errorMessage: e.toString()));
    }
  }
}
