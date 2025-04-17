// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/data/models/product_model.dart';
import 'package:freelance_task/features/products/data/repo/product_repo.dart';
part 'products_state.dart';

//? i could have separated the filter logic in another cubit but to save time i just put it in this cubit
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repo) : super(ProductsInitial()) {
    _loadProducts();
  }
  final ProductRepo _repo;

  final List<String> _categories = [];
  double _minPrice = 0;
  double _maxPrice = 1000;

  void toggleCategory(String category) {
    if (_categories.contains(category)) {
      _categories.remove(category);
    } else {
      _categories.add(category);
    }
    _refreshState();
  }

  bool categorySelected(String category) {
    return _categories.contains(category);
  }

  RangeValues get priceValues => RangeValues(_minPrice, _maxPrice);

  void changePrice(RangeValues range) {
    _minPrice = range.start;
    _maxPrice = range.end;
    _refreshState();
  }

  Future<void> _loadProducts() async {
    emit(ProductsLoading());
    var result = await _repo.getProducts(
      categories: _categories,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
    );
    result.fold(
      (error) => emit(ProductsError(error.message)),
      (products) => emit(ProductsSuccess(products)),
    );
  }

  void refresh() {
    _loadProducts();
  }

  void _refreshState() {
    var stateCopy = state;
    if (stateCopy is ProductsInitial) {
      emit(ProductsInitial());
    } else if (stateCopy is ProductsSuccess) {
      emit(ProductsSuccess(stateCopy.products));
    } else if (stateCopy is ProductsError) {
      emit(ProductsError(stateCopy.errMessage));
    }
    throw UnimplementedError();
  }
}
