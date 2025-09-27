import 'package:hive/hive.dart';

part "hivegeneratedadapter.dart";

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime dueDate;

  @HiveField(3)
  late String category;

  @HiveField(4)
  late bool isCompleted;

  @HiveField(5)
  late bool hasReminder;

  @HiveField(6)
  late ReminderType reminderType;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.category = 'Personal',
    this.isCompleted = false,
    this.hasReminder = false,
    this.reminderType = ReminderType.oneTime,
  });
}

@HiveType(typeId: 1)
enum ReminderType {
  @HiveField(0)
  oneTime,

  @HiveField(1)
  daily,
}
