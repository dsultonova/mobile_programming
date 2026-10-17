import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: HomeScreen()));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.push(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, secondaryAnimation) => const DetailsScreen(),
      transitionsBuilder: (_, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
    )), child: const Text('Open with fade'))));
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override Widget build(BuildContext context) => const Scaffold(appBar: null, body: Center(child: Text('I faded in!')));
}
