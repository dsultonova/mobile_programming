import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:api_catalog/data/product_api.dart';

void main() {
  test('getProducts parses a product from the response', () async {
    final productJson = jsonDecode(
      File('test/fixtures/product.json').readAsStringSync(),
    ) as Map<String, dynamic>;

    final pageJson = {
      'products': [productJson],
      'total': 1,
      'skip': 0,
      'limit': 20,
    };

    final client = MockClient((request) async {
      expect(request.url.path, '/products');

      return http.Response(
        jsonEncode(pageJson),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    addTearDown(client.close);

    final api = ProductApi(client: client);
    final page = await api.getProducts();

    expect(page.products, hasLength(1));
    expect(
      page.products.single.title,
      'Essence Mascara Lash Princess',
    );
  });

  test('getProduct throws ApiException for a 404 response', () async {
    final client = MockClient((request) async {
      return http.Response(
        '{"message":"Product not found"}',
        404,
      );
    });

    addTearDown(client.close);

    final api = ProductApi(client: client);

    await expectLater(
      api.getProduct(1),
      throwsA(isA<ApiException>()),
    );
  });
}