import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';
import 'widgets/product_tile.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return switch (state) {
            ProductsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ProductsError(:final message) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductsCubit>().load();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ProductsLoaded(:final products, :final total, :final hasMore) =>
              RefreshIndicator(
                onRefresh: () {
                  return context.read<ProductsCubit>().load();
                },
                child: ListView.builder(
                  itemCount: products.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == products.length) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().loadMore();
                            },
                            child: Text(
                              'Load more (${products.length} of $total)',
                            ),
                          ),
                        ),
                      );
                    }

                    return ProductTile(products[index]);
                  },
                ),
              ),
          };
        },
      ),
    );
  }
}