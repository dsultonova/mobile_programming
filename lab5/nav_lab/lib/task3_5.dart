import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: CounterHomeScreen()));
class CounterHomeScreen extends StatefulWidget {
  const CounterHomeScreen({super.key});
  @override State<CounterHomeScreen> createState() => _CounterHomeScreenState();
}
class _CounterHomeScreenState extends State<CounterHomeScreen> {
  int value = 0;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Edit counter')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Value: $value', style: const TextStyle(fontSize: 30)),
      ElevatedButton(onPressed: () async {
        final result = await Navigator.push<int>(context, MaterialPageRoute(builder: (_) => CounterEditorScreen(initialValue: value)));
        if (!mounted) return;
        if (result != null) setState(() => value = result);
      }, child: const Text('Edit')),
    ])));
}
class CounterEditorScreen extends StatefulWidget {
  final int initialValue;
  const CounterEditorScreen({super.key, required this.initialValue});
  @override State<CounterEditorScreen> createState() => _CounterEditorScreenState();
}
class _CounterEditorScreenState extends State<CounterEditorScreen> {
  late int value;
  @override void initState() { super.initState(); value = widget.initialValue; }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Editor')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('$value', style: const TextStyle(fontSize: 32)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(onPressed: () => setState(() => value--), icon: const Icon(Icons.remove)),
        IconButton(onPressed: () => setState(() => value++), icon: const Icon(Icons.add)),
      ]),
      ElevatedButton(onPressed: () => Navigator.pop(context, value), child: const Text('Save')),
    ])));
}
