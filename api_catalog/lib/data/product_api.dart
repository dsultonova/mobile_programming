
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/product_page.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ProductApi {
  ProductApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _host = 'dummyjson.com';

  // Endpoint 1: Get the product list
  Future<ProductPage> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    final uri = Uri.https(
      _host,
      '/products',
      {'limit': '$limit', 'skip': '$skip'},
    );

    return ProductPage.fromJson(await _get(uri));
  }

  // Endpoint 2: Get one product by ID
  Future<Product> getProduct(int id) async {
    final uri = Uri.https(_host, '/products/$id');

    return Product.fromJson(await _get(uri));
  }

  // Endpoint 3: Search products
  Future<ProductPage> search(String query) async {
    final uri = Uri.https(
      _host,
      '/products/search',
      {'q': query},
    );

    return ProductPage.fromJson(await _get(uri));
  }

  // Shared HTTP and JSON handling
  Future<Map<String, dynamic>> _get(Uri uri) async {
    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw ApiException(
          'Server answered ${response.statusCode}. Please try again.',
        );
      }

      return jsonDecode(response.body) as Map<String, dynamic>;
    } on TimeoutException {
      throw const ApiException(
        'The request took too long. Please try again.',
      );
    } on http.ClientException {
      throw const ApiException(
        'Connection failed. Please check your internet connection.',
      );
    } on FormatException {
      throw const ApiException(
        'The server returned invalid data.',
      );
    }
  }
}
