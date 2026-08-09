import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/task_item_widget.dart';

// =========================================================
// High Priority Screen
// =========================================================

class HighPriorityScreen
    extends StatefulWidget {
  const HighPriorityScreen({
    super.key,
  });

  @override
  State<HighPriorityScreen>
  createState() =>
      _HighPriorityScreenState();
}

// =========================================================
// Logic
// =========================================================

class _HighPriorityScreenState
    extends State<HighPriorityScreen> {
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
  // Load High Priority Tasks
  // =======================================================

  void _loadTasks() {
    final allTasks =
        PreferencesManager.instance.tasks;

    setState(() {
      tasks = allTasks
          .where(
            (task) =>
        task.isHighPriority,
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
          "High Priority Tasks",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),

      body: SafeArea(
        child: tasks.isEmpty
            ? Center(
          child: Text(
            "No high priority tasks",
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