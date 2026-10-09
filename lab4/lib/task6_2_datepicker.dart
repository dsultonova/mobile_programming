import 'package:flutter/material.dart';

class Task62DatePicker extends StatefulWidget {
  const Task62DatePicker({super.key});

  @override
  State<Task62DatePicker> createState() => _Task62DatePickerState();
}

class _Task62DatePickerState extends State<Task62DatePicker> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 6.2 - Date Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              selectedDate == null
                  ? 'No date selected'
                  : 'Selected date: '
                      '${selectedDate!.day}/'
                      '${selectedDate!.month}/'
                      '${selectedDate!.year}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickDate,
              child: const Text('Choose Date'),
            ),
          ],
        ),
      ),
    );
  }
}
