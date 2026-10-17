import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
CustomTransitionPage<void> buildPage(Widget child, GoRouterState state) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: const Duration(milliseconds: 400),
  transitionsBuilder: (_, animation, secondaryAnimation, child) {
    final slide = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
      .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
    final scale = Tween<double>(begin: 0.95, end: 1).animate(animation);
    return SlideTransition(position: slide, child: ScaleTransition(scale: scale, child: child));
  },
);
final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', pageBuilder: (_, state) => buildPage(const HomeScreen(), state)),
  GoRoute(path: '/details', pageBuilder: (_, state) => buildPage(const DetailsScreen(), state)),
]);
void main() => runApp(MaterialApp.router(routerConfig: router));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => context.push('/details'), child: const Text('Open details'))));
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Details')), body: const Center(child: Text('Slide + scale transition')));
}
