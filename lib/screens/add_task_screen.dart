import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

// =========================================================
// Add Task Screen
// =========================================================

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

// =========================================================
// Logic
// =========================================================

class _AddTaskScreenState
    extends State<AddTaskScreen> {

  // Controller لاسم التاسك
  final TextEditingController titleController =
  TextEditingController();

  // Controller للوصف
  final TextEditingController descriptionController =
  TextEditingController();

  // High Priority
  bool isHighPriority = true;

  // =======================================================
  // Dispose
  // =======================================================

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  // =======================================================
  // Add Task
  // =======================================================

  Future<void> addTask() async {
    final taskName =
    titleController.text.trim();

    // التأكد من وجود اسم
    if (taskName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a task name",
          ),
        ),
      );

      return;
    }

    // فتح SharedPreferences
    final pref =
    await SharedPreferences.getInstance();

    // جلب التاسكات القديمة
    final List<String> savedTasks =
        pref.getStringList("tasks") ?? [];

    // إنشاء التاسك
    final task = TaskModel(
      taskName: taskName,
      taskDescription:
      descriptionController.text.trim(),
      isHighPriority: isHighPriority,
      isCompleted: false,
    );

    // تحويلها إلى JSON
    final String taskJson =
    jsonEncode(task.toJson());

    // إضافة التاسك
    savedTasks.add(taskJson);

    // حفظ القائمة
    await pref.setStringList(
      "tasks",
      savedTasks,
    );

    if (!mounted) return;

    // رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Task added successfully",
        ),
      ),
    );

    // الرجوع للـ Home
    Navigator.pop(context);
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
        title: const Text(
          "New Task",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 13,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    const SizedBox(height: 8),

                    // =================================================
                    // Task Name
                    // =================================================

                    Text(
                      "Task Name",
                      style:
                      theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                      titleController,

                      style:
                      theme.textTheme.bodyMedium,

                      decoration:
                      const InputDecoration(
                        hintText:
                        "Finish UI design for login screen",
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // Description
                    // =================================================

                    Text(
                      "Task Description",
                      style:
                      theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller:
                      descriptionController,

                      maxLines: 5,

                      style:
                      theme.textTheme.bodyMedium,

                      decoration:
                      const InputDecoration(
                        hintText:
                        "Finish onboarding UI and hand off to\ndevs by Thursday.",
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // High Priority
                    // =================================================

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "High Priority",
                          style:
                          theme.textTheme.bodyMedium,
                        ),

                        Switch(
                          value: isHighPriority,

                          onChanged: (value) {
                            setState(() {
                              isHighPriority =
                                  value;
                            });
                          },

                          activeColor:
                          Colors.white,

                          activeTrackColor:
                          const Color(
                            0xFF52C070,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // =================================================
            // Add Button
            // =================================================

            Container(
              width: double.infinity,

              padding:
              const EdgeInsets.fromLTRB(
                13,
                8,
                13,
                24,
              ),

              color:
              theme.scaffoldBackgroundColor,

              child: SizedBox(
                height: 45,

                child: ElevatedButton(
                  onPressed: addTask,

                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.add,
                        size: 17,
                      ),

                      SizedBox(width: 7),

                      Text(
                        "Add Task",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}