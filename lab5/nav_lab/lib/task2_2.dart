import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(initialRoute: '/', routes: {
  '/': (_) => const MenuScreen(),
  '/profile': (_) => const InfoScreen(title: 'Profile', message: 'Your profile'),
  '/messages': (_) => const InfoScreen(title: 'Messages', message: 'Your messages'),
  '/about': (_) => const InfoScreen(title: 'About', message: 'About this app'),
}));
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Menu')),
    body: ListView(children: [
      for (final item in [('Profile', '/profile'), ('Messages', '/messages'), ('About', '/about')])
        ListTile(title: Text(item.$1), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.pushNamed(context, item.$2)),
    ]),
  );
}
class InfoScreen extends StatelessWidget {
  final String title, message;
  const InfoScreen({super.key, required this.title, required this.message});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(message)));
}
