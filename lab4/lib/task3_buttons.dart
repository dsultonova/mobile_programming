import 'package:flutter/material.dart';

class Task3Buttons extends StatefulWidget {
  const Task3Buttons({super.key});

  @override
  State<Task3Buttons> createState() => _Task3ButtonsState();
}

class _Task3ButtonsState extends State<Task3Buttons> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3 - Buttons'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter',
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: resetCounter,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}