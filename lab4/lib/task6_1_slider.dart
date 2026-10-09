import 'package:flutter/material.dart';

class Task61Slider extends StatefulWidget {
  const Task61Slider({super.key});

  @override
  State<Task61Slider> createState() => _Task61SliderState();
}

class _Task61SliderState extends State<Task61Slider> {
  double volume = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 6.1 - Volume Slider'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.volume_up,
                size: 50,
              ),
              const SizedBox(height: 20),
              Text(
                'Volume: ${volume.round()}%',
                style: const TextStyle(fontSize: 24),
              ),
              Slider(
                value: volume,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${volume.round()}%',
                onChanged: (value) {
                  setState(() {
                    volume = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
