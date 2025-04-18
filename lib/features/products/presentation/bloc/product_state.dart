// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:freelance_task/features/products/domain/enities/product_entity.dart';

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final List<String> categories;
  final List<String> selectedCategories;
  final double minPrice;
  final double maxPrice;
  final bool isLoading;
  final String? error;

  const ProductState({
    this.products = const [],
    this.categories = const [],
    this.selectedCategories = const [],
    this.minPrice = 0.0,
    this.maxPrice = 1000.0,
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<ProductEntity>? products,
    List<String>? categories,
    List<String>? selectedCategories,
    double? minPrice,
    double? maxPrice,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    products,
    categories,
    selectedCategories,
    minPrice,
    maxPrice,
    isLoading,
    error,
  ];
}
