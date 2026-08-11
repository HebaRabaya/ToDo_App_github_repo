// =========================================================
// Main Screen
// =========================================================
//
// هاي الشاشة هي الـ Container الرئيسي للتطبيق.
//
// فيها Bottom Navigation بين:
// - Home
// - Tasks
// - Completed
// - Profile
//
// =========================================================

import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'tasks_screen.dart';
import 'complete_tasks_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = const [
      HomeScreen(),
      TasksScreen(),
      CompleteTasksScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar:
      NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected:
            (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon:
            Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.task_outlined,
            ),
            selectedIcon:
            Icon(Icons.task),
            label: "Tasks",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            selectedIcon: Icon(
              Icons.check_circle,
            ),
            label: "Completed",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
            ),
            selectedIcon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}