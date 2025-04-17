// ignore_for_file: prefer_const_constructors
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/data/repo/product_repo.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._repo) : super(CategoriesInitial()) {
    _loadCategories();
  }
  final ProductRepo _repo;

  Future<void> _loadCategories() async {
    emit(CategoriesLoading());
    var result = await _repo.getCategories();
    result.fold(
      (error) => emit(CategoriesError(error.message)),
      (c) => emit(CategoriesSuccess(c)),
    );
  }
}
