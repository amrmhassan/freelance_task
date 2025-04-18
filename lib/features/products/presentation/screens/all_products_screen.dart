import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_bloc.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_event.dart';
import 'package:freelance_task/features/products/presentation/bloc/product_state.dart';
import 'package:freelance_task/features/products/presentation/widgets/filter_modal.dart';
import 'package:freelance_task/features/products/presentation/widgets/product_item_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  void _loadInitialData() {
    final bloc = context.read<ProductBloc>();
    bloc.add(const LoadProducts());
    bloc.add(const LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
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
                  return FilterModal();
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadInitialData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async => _loadInitialData(),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        },
      ),
    );
  }
}
