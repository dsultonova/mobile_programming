import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: GreetingFormScreen()));
class GreetingFormScreen extends StatefulWidget {
  const GreetingFormScreen({super.key});
  @override State<GreetingFormScreen> createState() => _GreetingFormScreenState();
}
class _GreetingFormScreenState extends State<GreetingFormScreen> {
  final controller = TextEditingController();
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Greeting')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      TextField(controller: controller, decoration: const InputDecoration(labelText: 'Your name', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      ElevatedButton(onPressed: () {
        final name = controller.text.trim();
        if (name.isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (_) => GreetingScreen(name: name)));
      }, child: const Text('Greet')),
    ])),
  );
}
class GreetingScreen extends StatelessWidget {
  final String name;
  const GreetingScreen({super.key, required this.name});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Greeting')),
    body: Center(child: Text('Hello, $name!', style: const TextStyle(fontSize: 28))));
}
