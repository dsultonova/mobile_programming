import 'package:flutter/material.dart';
class AppRoutes {
  static const home = '/';
  static const settings = '/settings';
}
void main() => runApp(MaterialApp(initialRoute: AppRoutes.home, routes: {
  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.settings: (_) => const SettingsScreen(),
}));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.settings), child: const Text('Settings'))),
  );
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Back'))),
  );
}
