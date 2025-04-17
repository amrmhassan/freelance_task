import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/manager/categories_cubit/categories_cubit.dart';
import 'package:freelance_task/features/products/manager/products_cubit/products_cubit.dart';
import 'package:freelance_task/features/products/view/widgets/category_widget.dart';
import 'package:freelance_task/features/products/view/widgets/height_space.dart';
import 'package:freelance_task/features/products/view/widgets/infinite_size.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    var cubitWatch = context.watch<ProductsCubit>();
    var cubit = context.read<ProductsCubit>();
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CategoriesSuccess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InfiniteSize(),
              HeightSpace(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      ...state.categories.map(
                        (c) => CategoryWidget(category: c),
                      ),
                    ],
                  ),
                ),
              ),
              HeightSpace(20),
              RangeSlider(
                divisions: 100,
                min: 0,
                max: 1000,
                values: cubitWatch.priceValues,
                onChanged: cubit.changePrice,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(cubitWatch.priceValues.start.toStringAsFixed(0)),
                    Spacer(),
                    Text(cubitWatch.priceValues.end.toStringAsFixed(0)),
                  ],
                ),
              ),
              HeightSpace(20),
              ElevatedButton(
                onPressed: () {
                  cubit.refresh();
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
              HeightSpace(10),
            ],
          );
        }
        if (state is CategoriesError) return Text(state.errMessage);
        return Text(state.runtimeType.toString());
      },
    );
  }
}
