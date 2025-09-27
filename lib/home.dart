import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_reminder_app/taskmodel.dart';
import 'package:task_reminder_app/taskwidgetlist.dart';

import 'addtaskscreenUI.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Work', 'Personal', 'Study'];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'My Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1E1E1E), const Color(0xFF2D2D2D)]
                        : [Colors.blue.shade50, Colors.purple.shade50],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _categories.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Row(
                          children: [
                            Icon(
                              _getCategoryIcon(choice),
                              color: _getCategoryColor(choice),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(choice),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.history_rounded),
                  onPressed: () {
                    // Navigate to history screen
                  },
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Filter Chips
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category;
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            selectedColor: _getCategoryColor(category).withOpacity(0.2),
                            checkmarkColor: _getCategoryColor(category),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? _getCategoryColor(category)
                                  : theme.textTheme.bodyLarge?.color,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            avatar: Icon(
                              _getCategoryIcon(category),
                              color: isSelected
                                  ? _getCategoryColor(category)
                                  : theme.textTheme.bodyLarge?.color,
                              size: 18,
                            ),
                            backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                            elevation: isSelected ? 2 : 0,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Task Count Header
                  ValueListenableBuilder(
                    valueListenable: Hive.box<Task>('tasks').listenable(),
                    builder: (context, Box<Task> box, _) {
                      final totalTasks = box.values.length;
                      final completedTasks = box.values.where((task) => task.isCompleted).length;
                      final pendingTasks = totalTasks - completedTasks;
                      
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [Colors.grey.shade800, Colors.grey.shade700]
                                : [Colors.white, Colors.grey.shade50],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatCard('Total', totalTasks.toString(), Icons.task_alt_rounded, Colors.blue),
                            _buildStatCard('Pending', pendingTasks.toString(), Icons.pending_actions_rounded, Colors.orange),
                            _buildStatCard('Completed', completedTasks.toString(), Icons.check_circle_rounded, Colors.green),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Tasks List
          ValueListenableBuilder(
            valueListenable: Hive.box<Task>('tasks').listenable(),
            builder: (context, Box<Task> box, _) {
              final tasks = box.values
                  .where((task) =>
                      !task.isCompleted &&
                      (_selectedCategory == 'All' || task.category == _selectedCategory))
                  .toList();
              
              if (tasks.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt_rounded,
                          size: 80,
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(0.3),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _selectedCategory == 'All' 
                              ? "No tasks yet. Add one!"
                              : "No ${_selectedCategory.toLowerCase()} tasks",
                          style: TextStyle(
                            fontSize: 18,
                            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tap the + button to create your first task",
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TaskList(tasks: [tasks[index]]),
                      );
                    },
                    childCount: tasks.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.purple.shade600],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyLarge?.color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Work':
        return Icons.work_rounded;
      case 'Personal':
        return Icons.person_rounded;
      case 'Study':
        return Icons.school_rounded;
      default:
        return Icons.all_inclusive_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Work':
        return Colors.blue;
      case 'Personal':
        return Colors.green;
      case 'Study':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}