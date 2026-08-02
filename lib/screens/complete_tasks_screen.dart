import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'tasks_screen.dart';


// =========================================================
// Completed Tasks Screen
// =========================================================

// هاي الصفحة رح نعرض فيها التاسكات المكتملة
// حاليًا لسا ما ضفنا اللوجيك تبعها
class CompleteTasksScreen extends StatefulWidget {

  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() =>
      _CompleteTasksScreenState();
}


class _CompleteTasksScreenState
    extends State<CompleteTasksScreen> {


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
      return;
    }


    // Profile
    if (index == 3) {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (_) =>
          const ProfileScreen(),
        ),
      );

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


        // زر الرجوع
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
          "Completed Tasks",

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
        child: Center(

          // حاليًا الصفحة فاضية
          // بعدين بنحط هون التاسكات المكتملة
          child: SizedBox(),
        ),
      ),


      // Bottom Navigation
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onItemSelected: onBottomNavTap,
      ),
    );
  }
}