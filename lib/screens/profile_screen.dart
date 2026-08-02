import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'complete_tasks_screen.dart';
import 'home_screen.dart';
import 'tasks_screen.dart';


// =========================================================
// Profile Screen
// =========================================================

// هاي صفحة الـ Profile
// حاليًا بس مجهزين الصفحة والتنقل
// والمحتويات رح نضيفها بعدين
class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}


class _ProfileScreenState
    extends State<ProfileScreen> {


  // =========================================================
  // التنقل بين الصفحات
  // =========================================================

  void onBottomNavTap(int index) {

    // Home
    if (index == 0) {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) => const HomeScreen(
            name: "",
          ),
        ),
      );

      return;
    }


    // To Do
    if (index == 1) {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const TasksScreen(),
        ),
      );

      return;
    }


    // Completed
    if (index == 2) {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const CompleteTasksScreen(),
        ),
      );

      return;
    }


    // Profile
    if (index == 3) {
      return;
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // خلفية الصفحة
      backgroundColor:
      const Color(0xFF181818),


      // =====================================================
      // App Bar
      // =====================================================

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF181818),

        elevation: 0,


        leading: IconButton(

          onPressed: () {
            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),


        title: const Text(
          "Profile",

          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),


      // =====================================================
      // محتوى الصفحة
      // =====================================================

      body: const SafeArea(
        child: SizedBox(),
      ),


      // Bottom Navigation
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onItemSelected: onBottomNavTap,
      ),
    );
  }
}