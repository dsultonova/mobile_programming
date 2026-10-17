import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  ),
  home: const HomeScreen(),
));
class FadeRoute<T> extends PageRouteBuilder<T> {
  FadeRoute(Widget page) : super(
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (_, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
  );
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.push(context, FadeRoute(const DetailsScreen())), child: const Text('Open with FadeRoute'))));
}
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Details')), body: const Center(child: Text('Reusable fade route')));
}
