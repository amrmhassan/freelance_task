import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/domain/repositories/product_repo.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_event.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _repo;
  ProductBloc(this._repo) : super(ProductState()) {
    on<LoadProducts>(_loadProducts);
    on<LoadCategories>(_loadCategories);
    on<ToggleSelectCategory>(_toggleCategory);
    on<UpdatePriceRange>(_updatePriceRange);
    add(LoadProducts());
  }

  Future<void> _loadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final res = await _repo.getProducts(
      categories: state.selectedCategories,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
    );
    res.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(state.copyWith(isLoading: false, products: r, error: null)),
    );
  }

  Future<void> _loadCategories(
    LoadCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _repo.getCategories();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) => emit(
        state.copyWith(isLoading: false, categories: categories, error: null),
      ),
    );
  }

  void _toggleCategory(ToggleSelectCategory event, Emitter<ProductState> emit) {
    var copy = [...state.selectedCategories];
    if (copy.contains(event.category)) {
      copy.remove(event.category);
    } else {
      copy.add(event.category);
    }
    emit(state.copyWith(selectedCategories: copy));
  }

  void _updatePriceRange(UpdatePriceRange event, Emitter<ProductState> emit) {
    emit(
      state.copyWith(minPrice: event.range.start, maxPrice: event.range.end),
    );
  }
}
