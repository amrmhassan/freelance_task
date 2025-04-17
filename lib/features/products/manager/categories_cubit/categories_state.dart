part of 'categories_cubit.dart';

sealed class CategoriesState {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<String> categories;
  const CategoriesSuccess(this.categories);
}

final class CategoriesError extends CategoriesState {
  final String errMessage;

  const CategoriesError(this.errMessage);
}
