import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// =========================================================
// Preferences Manager
// =========================================================

// هذا الملف مسؤول عن التعامل مع SharedPreferences
// بدل ما كل شاشة تتعامل معها لحالها.
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
    _prefs ??= await SharedPreferences.getInstance();
  }

  // =========================================================
  // Username
  // =========================================================

  String get username {
    return _prefs?.getString("username") ?? "";
  }

  Future<void> saveUsername(String username) async {
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

  Future<void> saveDarkMode(bool value) async {
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
  // Tasks
  // =========================================================

  List<String> get tasks {
    return _prefs?.getStringList("tasks") ?? [];
  }

  Future<void> saveTasks(
      List<String> tasks,
      ) async {
    await _prefs?.setStringList(
      "tasks",
      tasks,
    );
  }
}