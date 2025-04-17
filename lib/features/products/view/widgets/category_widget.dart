import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/manager/products_cubit/products_cubit.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var cubitWatch = context.watch<ProductsCubit>();
    var cubit = context.read<ProductsCubit>();
    bool active = cubitWatch.categorySelected(category);
    return GestureDetector(
      onTap: () => cubit.toggleCategory(category),
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: active ? Border.all(width: 1, color: Colors.green) : null,
        ),

        child: Text(category),
      ),
    );
  }
}
