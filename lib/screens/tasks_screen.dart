import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'complete_tasks_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';


// =========================================================
// To Do Tasks Screen
// =========================================================

// هاي الصفحة مسؤولة عن عرض التاسكات اللي لسا ما اكتملت
class TasksScreen extends StatefulWidget {

  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}


class _TasksScreenState extends State<TasksScreen> {

  // =========================================================
  // التنقل بين صفحات الـ Bottom Navigation
  // =========================================================

  void onBottomNavTap(int index) {

    // إذا ضغطنا على Home
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


    // إذا ضغطنا على To Do
    // إحنا أصلًا بصفحة To Do
    if (index == 1) {
      return;
    }


    // إذا ضغطنا على Completed
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


    // إذا ضغطنا على Profile
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

      // =====================================================
      // خلفية الصفحة
      // =====================================================

      backgroundColor:
      const Color(0xFF181818),


      // =====================================================
      // App Bar
      // =====================================================

      appBar: AppBar(

        // نفس لون خلفية التطبيق
        backgroundColor:
        const Color(0xFF181818),

        // بنشيل الظل
        elevation: 0,


        // زر الرجوع
        leading: IconButton(

          onPressed: () {

            // برجع للصفحة السابقة
            Navigator.pop(context);
          },


          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),


        // عنوان الصفحة
        title: const Text(
          "To Do Tasks",

          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),


      // =====================================================
      // محتوى الصفحة
      // =====================================================

      body: SafeArea(

        child: Column(
          children: [

            // =================================================
            // مكان التاسكات
            // =================================================

            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),

                child: Column(
                  children: [

                    // -------------------------------------------------
                    // مثال مؤقت للتاسكات
                    // -------------------------------------------------
                    //
                    // هاي حاليًا مجرد UI مؤقت
                    // بعدين بنربطها بالـ SharedPreferences
                    // ونجيب التاسكات الحقيقية
                    //

                    buildTaskItem(
                      "Finish video in flutter Course",
                      "Watch First video in elgndy website",
                    ),

                    buildTaskItem(
                      "Finish video in flutter Course",
                      "",
                    ),

                    buildTaskItem(
                      "Finish video in flutter Course",
                      "",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


      // =====================================================
      // Bottom Navigation
      // =====================================================

      bottomNavigationBar: BottomNavBar(

        // رقم 1 يعني إحنا بصفحة To Do
        currentIndex: 1,


        // لما المستخدم يضغط على أي أيقونة
        onItemSelected: onBottomNavTap,
      ),
    );
  }


  // =========================================================
  // شكل الـ Task
  // =========================================================

  // هاي الدالة بس بتعمل شكل التاسك
  // بعدين رح نستخدم TaskModel بدل النصوص الثابتة
  Widget buildTaskItem(
      String title,
      String description,
      ) {

    return Container(

      // مسافة بين كل Task والثانية
      margin:
      const EdgeInsets.only(bottom: 7),


      // مسافات داخل الـ Container
      padding:
      const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),


      // شكل خلفية التاسك
      decoration: BoxDecoration(

        color:
        const Color(0xFF292929),

        borderRadius:
        BorderRadius.circular(13),
      ),


      child: Row(
        children: [

          // =================================================
          // Checkbox
          // =================================================

          // حاليًا بس شكله موجود
          // اللوجيك الحقيقي رح نضيفه لما نربط الصفحة بالـ Tasks
          Checkbox(
            value: false,

            onChanged: (value) {
              // اللوجيك رح نضيفه لاحقًا
            },

            activeColor:
            const Color(0xFF00D084),

            checkColor:
            Colors.white,

            side:
            const BorderSide(
              color: Colors.white54,
            ),

            visualDensity:
            VisualDensity.compact,
          ),


          // =================================================
          // معلومات التاسك
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // اسم التاسك
                Text(
                  title,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),


                // إذا في Description بنعرضه
                if (description.isNotEmpty)
                  Text(
                    description,

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style:
                    const TextStyle(
                      color:
                      Color(0xFFBDBDBD),
                      fontSize: 9,
                    ),
                  ),
              ],
            ),
          ),


          // =================================================
          // الثلاث نقاط
          // =================================================

          const Icon(
            Icons.more_vert,

            color:
            Color(0xFF858585),

            size: 18,
          ),
        ],
      ),
    );
  }
}