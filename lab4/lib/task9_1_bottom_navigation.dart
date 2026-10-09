import 'package:flutter/material.dart';

class Task91BottomNavigation extends StatefulWidget {
  const Task91BottomNavigation({super.key});

  @override
  State<Task91BottomNavigation> createState() =>
      _Task91BottomNavigationState();
}

class _Task91BottomNavigationState
    extends State<Task91BottomNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    Center(
      child: Text(
        'Welcome to my flower garden 🌸',
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    ),
    Center(
      child: Text(
        'Explore beautiful flowers 🌷',
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    ),
    Center(
      child: Text(
        'My favorite flower: Lavender 💐',
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flower Garden'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: Colors.pink,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
