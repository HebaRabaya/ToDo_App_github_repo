import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

// =========================================================
// To Do Tasks Screen
// =========================================================

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

class _TasksScreenState
    extends State<TasksScreen> {

  // التاسكات غير المكتملة
  List<TaskModel> tasks = [];

  // =========================================================
  // بداية الشاشة
  // =========================================================

  @override
  void initState() {
    super.initState();

    loadTasks();
  }

  // =========================================================
  // تحميل التاسكات
  // =========================================================

  Future<void> loadTasks() async {
    final pref =
    await SharedPreferences.getInstance();

    final savedTasks =
        pref.getStringList("tasks") ?? [];

    final List<TaskModel> loadedTasks = [];

    for (final task in savedTasks) {
      try {
        final decoded = jsonDecode(task);

        final taskModel =
        TaskModel.fromJson(
          Map<String, dynamic>.from(decoded),
        );

        if (!taskModel.isCompleted) {
          loadedTasks.add(taskModel);
        }
      } catch (e) {
        // تجاهل أي Task فيها بيانات غير صحيحة
      }
    }

    if (!mounted) return;

    setState(() {
      tasks = loadedTasks;
    });
  }

  // =========================================================
  // تحديث حالة التاسك
  // =========================================================

  Future<void> updateTask(
      TaskModel task,
      bool value,
      ) async {
    final pref =
    await SharedPreferences.getInstance();

    final savedTasks =
        pref.getStringList("tasks") ?? [];

    final List<String> updatedTasks = [];

    for (final item in savedTasks) {
      final decoded = jsonDecode(item);

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
    }

    await pref.setStringList(
      "tasks",
      updatedTasks,
    );

    await loadTasks();
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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