import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_event.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_state.dart';
import 'package:freelance_task/features/products/presentation/widgets/category_widget.dart';
import 'package:freelance_task/features/products/presentation/widgets/height_space.dart';
import 'package:freelance_task/features/products/presentation/widgets/infinite_size.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});
  void _loadInitialData(BuildContext context) {
    final bloc = context.read<ProductBloc>();
    bloc.add(const LoadProducts());
    bloc.add(const LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ProductBloc>();
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.isLoading && state.categories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error != null && state.categories.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _loadInitialData(context),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

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
                    ...state.categories.map((c) => CategoryWidget(category: c)),
                  ],
                ),
              ),
            ),
            HeightSpace(20),
            RangeSlider(
              divisions: 100,
              min: 0,
              max: 1000,
              values: RangeValues(state.minPrice, state.maxPrice),
              onChanged: (v) => bloc.add(UpdatePriceRange(v)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(state.minPrice.toStringAsFixed(0)),
                  Spacer(),
                  Text(state.maxPrice.toStringAsFixed(0)),
                ],
              ),
            ),
            HeightSpace(20),
            ElevatedButton(
              onPressed: () {
                bloc.add(LoadProducts());
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
            HeightSpace(10),
          ],
        );
      },
    );
  }
}
