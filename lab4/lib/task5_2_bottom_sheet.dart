import 'package:flutter/material.dart';

class Task52BottomSheet extends StatelessWidget {
  const Task52BottomSheet({super.key});

  void showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text('Share'),
                leading: Icon(Icons.share),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Share via Messages'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Share via Email'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 5.2 - Bottom Sheet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showShareOptions(context);
          },
          child: const Text('Share'),
        ),
      ),
    );
  }
}
