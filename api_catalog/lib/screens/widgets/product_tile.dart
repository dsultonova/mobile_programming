import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.thumbnail,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: 60,
            height: 60,
            child: Icon(Icons.image_not_supported),
          );
        },
      ),
      title: Text(product.title),
      subtitle: Text(
        '\$${product.price.toStringAsFixed(2)} · ★ ${product.rating.toStringAsFixed(1)}',
      ),
    );
  }
}