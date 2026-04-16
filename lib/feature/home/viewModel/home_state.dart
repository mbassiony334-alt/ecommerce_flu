part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

/// Initial state — nothing has been requested yet.
final class HomeInitial extends HomeState {}

/// Data is being fetched from the API.
final class HomeLoading extends HomeState {}

/// All home data loaded successfully.
final class HomeLoaded extends HomeState {
  final List<ProductsModel> products;
  final List<CategoriesModel> categories;
  final List<Brand> brands;
  final String userName;

  HomeLoaded({
    required this.products,
    required this.categories,
    required this.brands,
    required this.userName,
  });
}

/// An error occurred while fetching home data.
final class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure({required this.errorMessage});
}
