import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: ColorHomeScreen()));
class ColorHomeScreen extends StatefulWidget {
  const ColorHomeScreen({super.key});
  @override State<ColorHomeScreen> createState() => _ColorHomeScreenState();
}
class _ColorHomeScreenState extends State<ColorHomeScreen> {
  Color current = Colors.blue;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Pick a colour')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 140, height: 140, color: current),
      const SizedBox(height: 20),
      ElevatedButton(onPressed: () async {
        final selected = await Navigator.push<Color>(context, MaterialPageRoute(builder: (_) => const ColorPickerScreen()));
        if (!mounted) return;
        if (selected != null) setState(() => current = selected);
      }, child: const Text('Choose colour')),
    ])));
}
class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Choose')),
    body: Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      for (final c in [Colors.red, Colors.green, Colors.blue])
        ElevatedButton(onPressed: () => Navigator.pop(context, c), style: ElevatedButton.styleFrom(backgroundColor: c), child: Text(c == Colors.red ? 'Red' : c == Colors.green ? 'Green' : 'Blue')),
    ])));
}
