import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_event.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_state.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductBloc>();
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        bool active = state.selectedCategories.contains(category);
        return GestureDetector(
          onTap: () => cubit.add(ToggleSelectCategory(category)),
          child: Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.green),
              color: active ? Colors.green : null,
            ),

            child: Text(
              category,
              style: TextStyle(color: active ? Colors.white : null),
            ),
          ),
        );
      },
    );
  }
}
