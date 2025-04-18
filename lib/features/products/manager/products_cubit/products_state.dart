part of 'products_cubit.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductEntity> products;
  const ProductsSuccess(this.products);
}

final class ProductsError extends ProductsState {
  final String errMessage;

  const ProductsError(this.errMessage);
}
