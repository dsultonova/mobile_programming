import 'package:flutter/material.dart';
class User {
  final String name, city; final int age;
  const User(this.name, this.age, this.city);
}
const demoUser = User('Maya', 21, 'Tashkent');
void main() => runApp(MaterialApp(initialRoute: '/', onGenerateRoute: (settings) {
  if (settings.name == '/') return MaterialPageRoute(builder: (_) => const HomeScreen());
  if (settings.name == '/profile') {
    final arg = settings.arguments;
    if (arg is User) return MaterialPageRoute(builder: (_) => ProfileScreen(user: arg));
    return MaterialPageRoute(builder: (_) => const NotFoundScreen());
  }
  return MaterialPageRoute(builder: (_) => const NotFoundScreen());
}));
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Home')),
    body: Center(child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/profile', arguments: demoUser), child: const Text('Open profile'))));
}
class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Profile')),
    body: Center(child: Text('${user.name}, ${user.age}, ${user.city}', style: const TextStyle(fontSize: 24))));
}
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Page not found')));
}
