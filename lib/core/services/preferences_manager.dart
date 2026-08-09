import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/task_model.dart';

// =========================================================
// Preferences Manager
// =========================================================

// هذا الملف مسؤول عن التعامل مع SharedPreferences.
//
// بدل ما كل شاشة تعمل:
// SharedPreferences.getInstance()
//
// بنخلي التعامل مع البيانات بمكان واحد.
class PreferencesManager extends ChangeNotifier {
  PreferencesManager._();

  // نسخة واحدة من PreferencesManager
  static final PreferencesManager instance =
  PreferencesManager._();

  SharedPreferences? _prefs;

  // =========================================================
  // Initialize
  // =========================================================

  Future<void> init() async {
    _prefs ??=
    await SharedPreferences.getInstance();
  }

  // =========================================================
  // Username
  // =========================================================

  String get username {
    return _prefs?.getString("username") ?? "";
  }

  Future<void> saveUsername(
      String username,
      ) async {
    await _prefs?.setString(
      "username",
      username,
    );

    notifyListeners();
  }

  // =========================================================
  // Dark Mode
  // =========================================================

  bool get isDarkMode {
    return _prefs?.getBool("isDarkMode") ?? true;
  }

  Future<void> saveDarkMode(
      bool value,
      ) async {
    await _prefs?.setBool(
      "isDarkMode",
      value,
    );

    notifyListeners();
  }

  // =========================================================
  // Logout
  // =========================================================

  Future<void> logout() async {
    await _prefs?.remove("username");

    notifyListeners();
  }

  // =========================================================
  // Get Tasks
  // =========================================================

  List<TaskModel> get tasks {
    final savedTasks =
        _prefs?.getStringList("tasks") ?? [];

    final List<TaskModel> loadedTasks = [];

    for (final item in savedTasks) {
      try {
        final decoded = jsonDecode(item);

        loadedTasks.add(
          TaskModel.fromJson(
            Map<String, dynamic>.from(decoded),
          ),
        );
      } catch (_) {
        // إذا كانت البيانات مش صحيحة
        // بنتجاهلها بدل ما التطبيق يوقع.
      }
    }

    return loadedTasks;
  }

  // =========================================================
  // Save Tasks
  // =========================================================

  Future<void> saveTasks(
      List<TaskModel> tasks,
      ) async {
    final encodedTasks = tasks
        .map(
          (task) => jsonEncode(
        task.toJson(),
      ),
    )
        .toList();

    await _prefs?.setStringList(
      "tasks",
      encodedTasks,
    );

    notifyListeners();
  }

  // =========================================================
  // Add Task
  // =========================================================

  Future<void> addTask(
      TaskModel task,
      ) async {
    final currentTasks = tasks;

    currentTasks.add(task);

    await saveTasks(currentTasks);
  }

  // =========================================================
  // Update Task
  // =========================================================

  Future<void> updateTask(
      TaskModel updatedTask,
      ) async {
    final currentTasks = tasks;

    final index = currentTasks.indexWhere(
          (task) =>
      task.taskId == updatedTask.taskId,
    );

    if (index == -1) {
      return;
    }

    currentTasks[index] = updatedTask;

    await saveTasks(currentTasks);
  }

  // =========================================================
  // Delete Task
  // =========================================================

  Future<void> deleteTask(
      String taskId,
      ) async {
    final currentTasks = tasks;

    currentTasks.removeWhere(
          (task) => task.taskId == taskId,
    );

    await saveTasks(currentTasks);
  }

  // =========================================================
  // Get One Task
  // =========================================================

  TaskModel? getTaskById(
      String taskId,
      ) {
    for (final task in tasks) {
      if (task.taskId == taskId) {
        return task;
      }
    }

    return null;
  }
}