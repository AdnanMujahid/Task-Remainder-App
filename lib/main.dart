import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_reminder_app/taskmodel.dart';
import 'home.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  // Registering the adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ReminderTypeAdapter());
  // Opening the box
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.system, // Automatically switch based on system settings
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
