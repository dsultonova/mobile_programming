import 'package:flutter/material.dart';

class Task72Dismissible extends StatefulWidget {
  const Task72Dismissible({super.key});

  @override
  State<Task72Dismissible> createState() =>
      _Task72DismissibleState();
}

class _Task72DismissibleState extends State<Task72Dismissible> {
  final List<String> flowers = [
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
        title: const Text('My Flower Collection 🌷'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: ListView.builder(
        itemCount: flowers.length,
        itemBuilder: (context, index) {
          final flower = flowers[index];

          return Dismissible(
            key: ValueKey(flower),
            background: Container(
              color: Colors.red.shade300,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red.shade300,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                flowers.remove(flower);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$flower removed from collection'),
                ),
              );
            },
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFCE4EC),
                child: Icon(
                  Icons.local_florist,
                  color: Colors.pink,
                ),
              ),
              title: Text(
                flower,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('Swipe to remove'),
              trailing: const Icon(Icons.swipe),
            ),
          );
        },
      ),
    );
  }
}
