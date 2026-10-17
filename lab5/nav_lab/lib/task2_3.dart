import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {'/': (_) => const HomeScreen()},
  onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const NotFoundScreen()),
));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/does-not-exist'), child: const Text('Open unknown route'))),
  );
}
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('404 - Not Found')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.error_outline, size: 64),
      const Text('Page not found'),
      ElevatedButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text('Return home')),
    ])),
  );
}
