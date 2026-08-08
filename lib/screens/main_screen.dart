import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'tasks_screen.dart';
import 'complete_tasks_screen.dart';
import 'profile_screen.dart';

import '../widgets/bottom_nav_bar.dart';

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

  // =========================================================
  // الصفحات
  // =========================================================

  final List<Widget> pages = const [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];

  // =========================================================
  // تغيير الصفحة
  // =========================================================

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // بنخلي لون الصفحة ياخذ من الـ Theme
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,

      // =====================================================
      // الصفحة الحالية
      // =====================================================

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // =====================================================
      // Bottom Navigation
      // =====================================================

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onItemSelected: changePage,
      ),
    );
  }
}