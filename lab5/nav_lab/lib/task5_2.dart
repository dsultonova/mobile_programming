import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: HomeScreen()));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Slide transition')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.push(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, secondaryAnimation) => const DetailsScreen(),
      transitionsBuilder: (_, animation, secondaryAnimation, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation), child: child),
    )), child: const Text('Slide from right'))));
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Details')), body: const Center(child: Text('Slid from the right!')));
}
