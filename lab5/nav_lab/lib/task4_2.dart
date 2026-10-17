import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(initialRoute: '/', routes: {
  '/': (_) => const HomeScreen(), '/square': (_) => const SquareScreen(),
}));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Choose a number')),
    body: Center(child: Wrap(spacing: 12, children: [for (final n in [1, 2, 3]) ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, '/square', arguments: n), child: Text('$n'))])));
}
class SquareScreen extends StatelessWidget {
  const SquareScreen({super.key});
  @override Widget build(BuildContext context) {
    final n = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(appBar: AppBar(title: const Text('Square')), body: Center(child: Text('$n squared = ${n * n}', style: const TextStyle(fontSize: 28))));
  }
}
