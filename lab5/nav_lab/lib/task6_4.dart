import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final router = GoRouter(initialLocation: '/', errorBuilder: (_, _) => const NotFoundScreen(), routes: [
  GoRoute(name: 'home', path: '/', builder: (_, _) => const HomeScreen()),
  GoRoute(name: 'settings', path: '/settings', builder: (_, _) => const SettingsScreen()),
  GoRoute(name: 'item', path: '/item/:id', builder: (_, state) => ItemScreen(id: state.pathParameters['id']!)),
]);
void main() => runApp(MaterialApp.router(routerConfig: router));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      ElevatedButton(onPressed: () => context.goNamed('settings'), child: const Text('Settings')),
      ElevatedButton(onPressed: () => context.goNamed('item', pathParameters: {'id': '42'}), child: const Text('Open item 42')),
    ])));
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Settings')), body: const Center(child: Text('Settings page')));
}
class ItemScreen extends StatelessWidget {
  final String id;
  const ItemScreen({super.key, required this.id});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Item')), body: Center(child: Text('Item ID: $id')));
}
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Page not found (404)')));
}
