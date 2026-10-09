import 'package:flutter/material.dart';

class Task4_2SnackBar extends StatelessWidget {
  const Task4_2SnackBar({super.key});

  void showMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Action completed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            print('Undo pressed');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.2 - SnackBar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showMessage(context);
          },
          child: const Text('Complete Action'),
        ),
      ),
    );
  }
}