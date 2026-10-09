import 'package:flutter/material.dart';
import 'dart:async';

class Task4_1Loading extends StatefulWidget {
  const Task4_1Loading({super.key});

  @override
  State<Task4_1Loading> createState() => _Task4_1LoadingState();
}

class _Task4_1LoadingState extends State<Task4_1Loading> {
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 4.1 - Loading'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: startLoading,
                child: const Text('Start'),
              ),
      ),
    );
  }
}