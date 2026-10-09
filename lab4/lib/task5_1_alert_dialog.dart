import 'package:flutter/material.dart';

class Task51AlertDialog extends StatelessWidget {
  const Task51AlertDialog({super.key});

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item?'),
          content: const Text(
            'Are you sure you want to delete this item?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item deleted'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 5.1 - AlertDialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDeleteDialog(context);
          },
          child: const Text('Delete Item'),
        ),
      ),
    );
  }
}