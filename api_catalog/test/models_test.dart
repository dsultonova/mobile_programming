
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:api_catalog/models/product.dart';
void main() {
  group('Product model', () {
    test('parses the saved JSON fixture correctly', () {
      final file = File('test/fixtures/product.json');
      final json =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      final product = Product.fromJson(json);

      expect(product.title, 'Essence Mascara Lash Princess');
      expect(product.price, isA<double>());
      expect(product.tags.length, greaterThanOrEqualTo(2));
      expect(product.reviews.length, 3);
    });

    test('handles a missing optional brand', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'price': 10,
        'rating': 4.5,
        'tags': ['beauty', 'mascara'],
        'thumbnail': 'https://example.com/image.jpg',
        'dimensions': {
          'width': 1,
          'height': 2,
          'depth': 3,
        },
        'reviews': [],
      };

      final product = Product.fromJson(json);

      expect(product.brand, isNull);
    });

    test('throws an error when tags are missing', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'price': 10,
        'rating': 4.5,
        'thumbnail': 'https://example.com/image.jpg',
        'dimensions': {
          'width': 1,
          'height': 2,
          'depth': 3,
        },
        'reviews': [],
      };

      expect(
        () => Product.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
