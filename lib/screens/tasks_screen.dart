import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/task_item_widget.dart';

// =========================================================
// To Do Tasks Screen
// =========================================================

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

// =========================================================
// Logic
// =========================================================

class _TasksScreenState
    extends State<TasksScreen> {
  List<TaskModel> tasks = [];

  // =======================================================
  // Init
  // =======================================================

  @override
  void initState() {
    super.initState();

    _loadTasks();
  }

  // =======================================================
  // Load Tasks
  // =======================================================

  void _loadTasks() {
    final allTasks =
        PreferencesManager.instance.tasks;

    setState(() {
      tasks = allTasks
          .where(
            (task) => !task.isCompleted,
      )
          .toList();
    });
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "To Do Tasks",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),

      body: SafeArea(
        child: tasks.isEmpty
            ? Center(
          child: Text(
            "No tasks to do",
            style: theme
                .textTheme
                .bodySmall,
          ),
        )
            : ListView.builder(
          padding:
          const EdgeInsets
              .all(13),

          itemCount:
          tasks.length,

          itemBuilder:
              (context, index) {
            return TaskItemWidget(
              task:
              tasks[index],

              onTaskUpdated:
              _loadTasks,
            );
          },
        ),
      ),
    );
  }
}