import 'package:flutter/material.dart';

import 'complete_tasks_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';

// =========================================================
// Main Screen
// =========================================================

// هاي الشاشة مسؤولة عن التنقل بين الصفحات الرئيسية.
//
// 0 = Home
// 1 = To Do
// 2 = Completed
// 3 = Profile
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

// =========================================================
// Main Screen Logic
// =========================================================

class _MainScreenState
    extends State<MainScreen> {
  // الصفحة الحالية
  int currentIndex = 0;

  // =======================================================
  // Pages
  // =======================================================

  final List<Widget> pages = const [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];

  // =======================================================
  // Change Page
  // =======================================================

  void changePage(
      int index,
      ) {
    setState(() {
      currentIndex = index;
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

      // =====================================================
      // Current Page
      // =====================================================

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // =====================================================
      // Bottom Navigation
      // =====================================================

      bottomNavigationBar:
      NavigationBar(
        selectedIndex:
        currentIndex,

        onDestinationSelected:
        changePage,

        backgroundColor:
        theme.cardColor,

        indicatorColor:
        theme.colorScheme.primary
            .withValues(
          alpha: 0.15,
        ),

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
              Icons
                  .checklist_outlined,
            ),
            selectedIcon:
            Icon(Icons.checklist),
            label: "To Do",
          ),

          NavigationDestination(
            icon: Icon(
              Icons
                  .task_alt_outlined,
            ),
            selectedIcon:
            Icon(Icons.task_alt),
            label: "Done",
          ),

          NavigationDestination(
            icon: Icon(
              Icons
                  .person_outline,
            ),
            selectedIcon:
            Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}