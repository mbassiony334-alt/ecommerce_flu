part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}

final class CartSuccess extends CartState {}

final class ListCartSuccess extends CartState {
  final List<ProductsModel> car;

  ListCartSuccess({required this.car});
}

final class CartFailure extends CartState {
  final String errorMessage;

  CartFailure({required this.errorMessage});
}

final class DelCartSuccess extends CartState {}

final class DelCartFaliure extends CartState {
  final String errorMessage;

  DelCartFaliure({required this.errorMessage});
}
