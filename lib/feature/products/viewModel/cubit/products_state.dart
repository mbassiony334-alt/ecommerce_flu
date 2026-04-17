part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductSuccess extends ProductsState {
  final List<ProductsModel> products;

  ProductSuccess({required this.products});
}

final class ProductsFailure extends ProductsState {
  final String errorMessage;

  ProductsFailure({required this.errorMessage});
}

final class SpecificProductSuccess extends ProductsState {
 final ProductsModel product;

  SpecificProductSuccess({ required this.product});
}
