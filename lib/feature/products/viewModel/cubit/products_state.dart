part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductSuccess extends ProductsState {
  final List<ProductsModel> products;

  ProductSuccess({required this.products});
}

final class ProductsFaliure extends ProductsState {
  final String errorMessage;

  ProductsFaliure({required this.errorMessage});
}

final class SpecficProductSuccess extends ProductsState {
 final ProductsModel product;

  SpecficProductSuccess({ required this.product});
}
