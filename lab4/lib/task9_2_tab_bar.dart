import 'package:flutter/material.dart';

class Task92TabBar extends StatelessWidget {
  const Task92TabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flower Collection'),
          backgroundColor: Colors.pink.shade100,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.local_florist),
                text: 'Flowers',
              ),
              Tab(
                icon: Icon(Icons.park),
                text: 'Garden',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text(
                'Discover beautiful flowers 🌸',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'Welcome to the garden 🌿',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'My favorite flowers 💐',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
