part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}

final class FavLoading extends FavState {}

final class FavSuccess extends FavState {}

final class ListFavSuccess extends FavState {
  final List<ProductsModel> faovourite;

  ListFavSuccess({required this.faovourite});
}

final class FavFailure extends FavState {
  final String errorMessage;

  FavFailure({required this.errorMessage});
}

final class DelFavSuccess extends FavState {}

final class DelFavFaliure extends FavState {
  final String errorMessage;

  DelFavFaliure({required this.errorMessage});
}
