import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(initialRoute: '/', routes: {
  '/': (_) => const SectionScreen(title: 'Home'),
  '/profile': (_) => const SectionScreen(title: 'Profile'),
  '/messages': (_) => const SectionScreen(title: 'Messages'),
  '/about': (_) => const SectionScreen(title: 'About'),
}));
class SectionScreen extends StatelessWidget {
  final String title;
  const SectionScreen({super.key, required this.title});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    drawer: Drawer(child: ListView(children: [
      const DrawerHeader(child: Text('Navigation', style: TextStyle(fontSize: 22))),
      for (final item in [('Home', '/'), ('Profile', '/profile'), ('Messages', '/messages'), ('About', '/about')])
        ListTile(title: Text(item.$1), onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, item.$2);
        }),
    ])),
    body: Center(child: Text('$title page')),
  );
}
