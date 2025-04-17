// ignore_for_file: prefer_const_constructors
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/data/models/product_model.dart';
import 'package:freelance_task/features/products/data/repo/product_repo.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repo) : super(ProductsInitial()) {
    _loadProducts();
  }
  final ProductRepo _repo;

  void refresh() {}

  Future<void> _loadProducts() async {
    emit(ProductsLoading());
    var result = await _repo.getProducts();
    result.fold(
      (error) => emit(ProductsError(error.message)),
      (products) => emit(ProductsSuccess(products)),
    );
  }
}
