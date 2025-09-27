import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_reminder_app/taskmodel.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _dueDate;
  late String _category;
  bool _hasReminder = false;
  ReminderType _reminderType = ReminderType.oneTime;

  final List<String> _categories = ['Work', 'Personal', 'Study'];

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _dueDate = widget.task?.dueDate ?? DateTime.now();
    _category = widget.task?.category ?? 'Personal';
    _hasReminder = widget.task?.hasReminder ?? false;
    _reminderType = widget.task?.reminderType ?? ReminderType.oneTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dueDate),
      );
      if (pickedTime != null) {
        setState(() {
          _dueDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final tasksBox = Hive.box<Task>('tasks');
      if (widget.task != null) {
        // Update existing task
        widget.task!.title = _title;
        widget.task!.description = _description;
        widget.task!.dueDate = _dueDate;
        widget.task!.category = _category;
        widget.task!.hasReminder = _hasReminder;
        widget.task!.reminderType = _reminderType;
        widget.task!.save();
      } else {
        // Add new task
        final newTask = Task(
          title: _title,
          description: _description,
          dueDate: _dueDate,
          category: _category,
          hasReminder: _hasReminder,
          reminderType: _reminderType,
        );
        tasksBox.add(newTask);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Due Date: ${_dueDate.toLocal().toString().split(' ')[0]} ${_dueDate.hour}:${_dueDate.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date & Time'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Set Reminder'),
                value: _hasReminder,
                onChanged: (bool value) {
                  setState(() {
                    _hasReminder = value;
                  });
                },
              ),
              if (_hasReminder)
                Column(
                  children: [
                    RadioListTile<ReminderType>(
                      title: const Text('One-time'),
                      value: ReminderType.oneTime,
                      groupValue: _reminderType,
                      onChanged: (ReminderType? value) {
                        setState(() {
                          _reminderType = value!;
                        });
                      },
                    ),
                    RadioListTile<ReminderType>(
                      title: const Text('Daily'),
                      value: ReminderType.daily,
                      groupValue: _reminderType,
                      onChanged: (ReminderType? value) {
                        setState(() {
                          _reminderType = value!;
                        });
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
