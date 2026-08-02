import 'package:flutter/material.dart';


// =========================================================
// Bottom Navigation Bar
// =========================================================

// هذا الـ Widget مسؤول عن شريط التنقل اللي تحت التطبيق
// بنستخدمه بكل الصفحات بدل ما نكرر نفس الكود بكل صفحة
class BottomNavBar extends StatelessWidget {

  // رقم الصفحة الحالية
  // 0 = Home
  // 1 = To Do
  // 2 = Completed
  // 3 = Profile
  final int currentIndex;


  // هاي الدالة بتشتغل لما المستخدم يضغط على أي أيقونة
  final Function(int) onItemSelected;


  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });


  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(

      // لون خلفية الـ Bottom Navigation
      backgroundColor:
      const Color(0xFF181818),


      // بخلي كل العناصر ظاهرين بنفس الشكل
      type: BottomNavigationBarType.fixed,


      // لون الأيقونة لما تكون الصفحة الحالية
      selectedItemColor:
      const Color(0xFF00D084),


      // لون الأيقونات اللي مش مختارة
      unselectedItemColor:
      Colors.white70,


      // بنحدد أي صفحة هي الحالية
      currentIndex: currentIndex,


      // بنظهر أسماء الصفحات
      showSelectedLabels: true,
      showUnselectedLabels: true,


      // حجم الخط تحت الأيقونات
      selectedFontSize: 9,
      unselectedFontSize: 9,


      // لما المستخدم يضغط على أي أيقونة
      onTap: onItemSelected,


      // =====================================================
      // صفحات الـ Bottom Navigation
      // =====================================================

      items: const [

        // الصفحة الرئيسية
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),

          activeIcon:
          Icon(Icons.home),

          label: "Home",
        ),


        // صفحة الـ To Do
        BottomNavigationBarItem(
          icon:
          Icon(Icons.description_outlined),

          activeIcon:
          Icon(Icons.description),

          label: "To Do",
        ),


        // صفحة التاسكات المكتملة
        BottomNavigationBarItem(
          icon:
          Icon(Icons.fact_check_outlined),

          activeIcon:
          Icon(Icons.fact_check),

          label: "Completed",
        ),


        // صفحة البروفايل
        BottomNavigationBarItem(
          icon:
          Icon(Icons.person_outline),

          activeIcon:
          Icon(Icons.person),

          label: "Profile",
        ),
      ],
    );
  }
}