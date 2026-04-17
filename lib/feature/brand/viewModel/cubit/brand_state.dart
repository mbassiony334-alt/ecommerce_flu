part of 'brand_cubit.dart';

@immutable
sealed class BrandState {}

final class BrandInitial extends BrandState {}

final class BrandLoading extends BrandState {}

final class BrandSuccess extends BrandState {
 final List<Brand> brands;

  BrandSuccess({required this.brands});
}

final class BrandFailure extends BrandState {
  final String errorMessage;

  BrandFailure({required this.errorMessage});
}
