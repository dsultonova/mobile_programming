import 'package:flutter/material.dart';
class Contact {
  final String name, phone, email;
  const Contact(this.name, this.phone, this.email);
}
const contacts = [
  Contact('Ada Lovelace', '+998 90 111 1111', 'ada@example.com'),
  Contact('Alan Turing', '+998 90 222 2222', 'alan@example.com'),
  Contact('Grace Hopper', '+998 90 333 3333', 'grace@example.com'),
  Contact('Katherine Johnson', '+998 90 444 4444', 'katherine@example.com'),
  Contact('Tim Berners-Lee', '+998 90 555 5555', 'tim@example.com'),
];
void main() => runApp(const MaterialApp(home: ContactListScreen()));
class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Contacts')),
    body: ListView(children: [for (final c in contacts) ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(c.name), subtitle: Text(c.phone),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(contact: c))),
    )]));
}
class ContactScreen extends StatelessWidget {
  final Contact contact;
  const ContactScreen({super.key, required this.contact});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(contact.name)),
    body: Card(margin: const EdgeInsets.all(20), child: Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(contact.name, style: Theme.of(context).textTheme.headlineSmall),
      ListTile(leading: const Icon(Icons.phone), title: Text(contact.phone)),
      ListTile(leading: const Icon(Icons.email), title: Text(contact.email)),
    ]))));
}
