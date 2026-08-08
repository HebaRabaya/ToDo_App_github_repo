import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

// =========================================================
// High Priority Screen
// =========================================================

class HighPriorityScreen
    extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() =>
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

    loadTasks();
  }

  // =======================================================
  // Load High Priority
  // =======================================================

  Future<void> loadTasks() async {
    final pref =
    await SharedPreferences.getInstance();

    final savedTasks =
        pref.getStringList("tasks") ?? [];

    final List<TaskModel> loadedTasks =
    [];

    for (final item in savedTasks) {
      try {
        final decoded =
        jsonDecode(item);

        final task =
        TaskModel.fromJson(
          Map<String, dynamic>.from(decoded),
        );

        if (task.isHighPriority) {
          loadedTasks.add(task);
        }
      } catch (_) {}
    }

    if (!mounted) return;

    setState(() {
      tasks = loadedTasks;
    });
  }

  // =======================================================
  // Update Task
  // =======================================================

  Future<void> updateTask(
      TaskModel task,
      bool value,
      ) async {
    final pref =
    await SharedPreferences.getInstance();

    final savedTasks =
        pref.getStringList("tasks") ?? [];

    final List<String> updatedTasks =
    [];

    for (final item in savedTasks) {
      try {
        final decoded =
        jsonDecode(item);

        final currentTask =
        TaskModel.fromJson(
          Map<String, dynamic>.from(decoded),
        );

        if (currentTask.taskName ==
            task.taskName &&
            currentTask.taskDescription ==
                task.taskDescription) {

          final updatedTask =
          currentTask.copyWith(
            isCompleted: value,
          );

          updatedTasks.add(
            jsonEncode(
              updatedTask.toJson(),
            ),
          );
        } else {
          updatedTasks.add(item);
        }
      } catch (_) {
        updatedTasks.add(item);
      }
    }

    await pref.setStringList(
      "tasks",
      updatedTasks,
    );

    await loadTasks();
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
          ),
        ),

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
            style:
            theme.textTheme.bodySmall,
          ),
        )
            : ListView.builder(
          padding:
          const EdgeInsets.all(13),

          itemCount:
          tasks.length,

          itemBuilder:
              (context, index) {

            final task =
            tasks[index];

            return TaskListWidget(
              task: task,

              onChanged: (value) {
                if (value != null) {
                  updateTask(
                    task,
                    value,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}