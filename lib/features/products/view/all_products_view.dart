import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/core/services.dart';
import 'package:freelance_task/features/products/data/impl/product_repo_impl.dart';
import 'package:freelance_task/features/products/manager/categories_cubit/categories_cubit.dart';
import 'package:freelance_task/features/products/manager/products_cubit/products_cubit.dart';
import 'package:freelance_task/features/products/view/widgets/filter_modal.dart';
import 'package:freelance_task/features/products/view/widgets/product_item_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create:
                        (context) => CategoriesCubit(getIt<ProductRepoImpl>()),
                    child: FilterModal(),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errMessage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: cubit.refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsSuccess) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async => cubit.refresh(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductItemWidget(product: product);
                    },
                  ),
                ),
              ],
            );
          }

          return Text(state.runtimeType.toString());
        },
      ),
    );
  }
}
