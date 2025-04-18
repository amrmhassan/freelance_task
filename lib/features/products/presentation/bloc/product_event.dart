import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class LoadCategories extends ProductEvent {
  const LoadCategories();
}

class ToggleSelectCategory extends ProductEvent {
  final String category;
  const ToggleSelectCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdatePriceRange extends ProductEvent {
  final RangeValues range;
  const UpdatePriceRange(this.range);

  @override
  List<Object?> get props => [range.start, range.end];
}

class ApplyFilters extends ProductEvent {
  const ApplyFilters();
}
