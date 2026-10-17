import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (_, _) => const HomeScreen()),
  GoRoute(path: '/product/:id', builder: (_, state) => ProductScreen(id: state.pathParameters['id']!)),
]);
void main() => runApp(MaterialApp.router(routerConfig: router));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Products')),
    body: Center(child: Wrap(spacing: 12, children: [for (final id in ['1', '2', '3']) ElevatedButton(
      onPressed: () => context.push('/product/$id'), child: Text('Product $id'))])));
}
class ProductScreen extends StatelessWidget {
  final String id;
  const ProductScreen({super.key, required this.id});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Product $id')), body: Center(child: Text('Product #$id', style: const TextStyle(fontSize: 28))));
}
