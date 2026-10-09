import 'package:flutter/material.dart';

class Task71ListView extends StatelessWidget {
  const Task71ListView({super.key});

  final List<String> flowers = const [
    'Rose',
    'Tulip',
    'Sunflower',
    'Lily',
    'Orchid',
    'Daisy',
    'Lavender',
    'Jasmine',
    'Peony',
    'Daffodil',
    'Lotus',
    'Hibiscus',
    'Violet',
    'Iris',
    'Marigold',
    'Poppy',
    'Magnolia',
    'Camellia',
    'Chrysanthemum',
    'Hydrangea',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flower Collection 🌸'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: ListView.builder(
        itemCount: flowers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFFCE4EC),
              child: Icon(
                Icons.local_florist,
                color: Colors.pink,
              ),
            ),
            title: Text(
              flowers[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text('A beautiful flower'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          );
        },
      ),
    );
  }
}
