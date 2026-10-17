import 'package:flutter/material.dart';
class User {
  final String name, city; final int age;
  const User(this.name, this.age, this.city);
}
const users = [User('Maya', 21, 'Tashkent'), User('Aziz', 22, 'Khiva'), User('Sara', 20, 'Samarkand'), User('Jasur', 23, 'Bukhara')];
void main() => runApp(MaterialApp(initialRoute: '/', routes: {'/': (_) => const UserListScreen(), '/profile': (_) => const ProfileScreen()}));
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Users')),
    body: ListView(children: [for (final user in users) ListTile(title: Text(user.name), subtitle: Text(user.city), onTap: () => Navigator.pushNamed(context, '/profile', arguments: user))]));
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(appBar: AppBar(title: Text(user.name)), body: Card(margin: const EdgeInsets.all(20), child: ListTile(
      leading: const Icon(Icons.person, size: 40), title: Text(user.name), subtitle: Text('Age: ${user.age}\nCity: ${user.city}'))));
  }
}
