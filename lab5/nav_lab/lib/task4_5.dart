import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(home: const MovieHomeScreen(), onGenerateRoute: (settings) {
  if (settings.name == '/rate') return MaterialPageRoute(builder: (_) => RateScreen(title: settings.arguments as String));
  return null;
}));
class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});
  @override State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}
class _MovieHomeScreenState extends State<MovieHomeScreen> {
  int? rating;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Movie rating')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(rating == null ? 'Movie: not rated' : 'Movie: $rating/5', style: const TextStyle(fontSize: 24)),
      ElevatedButton(onPressed: () async {
        final result = await Navigator.pushNamed<int>(context, '/rate', arguments: 'The Movie');
        if (!mounted) return;
        setState(() => rating = result);
      }, child: const Text('Rate movie')),
    ])));
}
class RateScreen extends StatelessWidget {
  final String title;
  const RateScreen({super.key, required this.title});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Rate $title')),
    body: Center(child: Wrap(children: [for (int i = 1; i <= 5; i++) IconButton(
      icon: const Icon(Icons.star, color: Colors.amber, size: 36), onPressed: () => Navigator.pop(context, i))])));
}
