import 'package:flutter/material.dart';

import 'task1_selection.dart';
import 'task2_input.dart';
import 'task3_buttons.dart';
import 'task4_1_loading.dart';
import 'task4_2_snackbar.dart';
import 'task5_1_alert_dialog.dart';
import 'task5_2_bottom_sheet.dart';
import 'task6_1_slider.dart';
import 'task6_2_datepicker.dart';
import 'task7_1_listviewer.dart';
import 'task7_2_dismissible.dart';
import 'task8_1_grid_gallery.dart';
import 'task8_2_imagepreview.dart';
import 'task9_1_bottom_navigation.dart';
import 'task9_2_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Programming Lab 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
      ),
      home: const TaskMenu(),
    );
  }
}

class TaskMenu extends StatelessWidget {
  const TaskMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = <(String, String, IconData, Widget)>[
      (
        'Task 1.1–1.2',
        'Selection Controls',
        Icons.toggle_on,
        const Task1Selection(),
      ),
      (
        'Task 2.1–2.2',
        'Input Fields',
        Icons.input,
        const Task2Input(),
      ),
      (
        'Task 3',
        'Reset Counter',
        Icons.restart_alt,
        const Task3Buttons(),
      ),
      (
        'Task 4.1',
        'Loading Indicator',
        Icons.refresh,
        const Task4_1Loading(),
      ),
      (
        'Task 4.2',
        'SnackBar',
        Icons.notifications_outlined,
        const Task4_2SnackBar(),
      ),
      (
        'Task 5.1',
        'Delete Confirmation',
        Icons.delete_outline,
        const Task51AlertDialog(),
      ),
      (
        'Task 5.2',
        'Share Options',
        Icons.share_outlined,
        const Task52BottomSheet(),
      ),
      (
        'Task 6.1',
        'Volume Slider',
        Icons.volume_up,
        const Task61Slider(),
      ),
      (
        'Task 6.2',
        'Date Picker',
        Icons.calendar_month,
        const Task62DatePicker(),
      ),
      (
        'Task 7.1',
        'Flower List',
        Icons.list,
        const Task71ListView(),
      ),
      (
        'Task 7.2',
        'Swipe to Remove',
        Icons.swipe,
        const Task72Dismissible(),
      ),
      (
        'Task 8.1',
        'Flower Image Gallery',
        Icons.grid_view,
        const Task81ImageGrid(),
      ),
      (
        'Task 8.2',
        'Full-Screen Image Preview',
        Icons.image_outlined,
        const Task82ImagePreview(),
      ),
      (
        'Task 9.1',
        'Bottom Navigation',
        Icons.navigation,
        const Task91BottomNavigation(),
      ),
      (
        'Task 9.2',
        'Top Tabs',
        Icons.tab,
        const Task92TabBar(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Programming Lab 4'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Flutter Widgets 🌸',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text('Choose an exercise to get started.'),
          const SizedBox(height: 16),
          ...exercises.map((exercise) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(
                  exercise.$3,
                  color: Colors.pink,
                  size: 30,
                ),
                title: Text(
                  exercise.$1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(exercise.$2),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => exercise.$4,
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}