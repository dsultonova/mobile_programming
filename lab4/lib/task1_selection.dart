import 'package:flutter/material.dart';

class Task1Selection extends StatefulWidget {
  const Task1Selection({super.key});

  @override
  State<Task1Selection> createState() => _Task1SelectionState();
}

class _Task1SelectionState extends State<Task1Selection> {
  bool isDarkMode = false;
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task 1 - Selection Controls'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),

            CheckboxListTile(
              title: const Text('Agree to Terms'),
              value: agreeToTerms,
              onChanged: (value) {
                setState(() {
                  agreeToTerms = value ?? false;
                });
              },
            ),

            ElevatedButton(
              onPressed: agreeToTerms
                  ? () {
                      print('Continue pressed');
                    }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}