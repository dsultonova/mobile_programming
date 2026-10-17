import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: HomeScreen()));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Route<void> _bottomSheetRoute() => PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (_, _, _) => const DetailsScreen(),
    transitionsBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return SlideTransition(position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(curved), child: child);
    },
  );
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Transitions')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.push(context, _bottomSheetRoute()), child: const Text('Open as a sheet'))));
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Sheet-style page')), body: const Center(child: Text('Slides from bottom')));
}
