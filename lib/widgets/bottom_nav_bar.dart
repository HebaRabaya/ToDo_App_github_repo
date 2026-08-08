import 'package:flutter/material.dart';

// =========================================================
// Bottom Navigation Bar
// =========================================================

// هذا الـ Widget مسؤول عن الأيقونات اللي تحت
class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  final Function(int) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
      ),

      child: SafeArea(
        child: SizedBox(
          height: 65,

          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,

            children: [

              // Home
              _buildItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: "Home",
                index: 0,
              ),

              // To Do
              _buildItem(
                icon: Icons.checklist_outlined,
                selectedIcon: Icons.checklist,
                label: "To Do",
                index: 1,
              ),

              // Completed
              _buildItem(
                icon: Icons.task_alt_outlined,
                selectedIcon: Icons.task_alt,
                label: "Done",
                index: 2,
              ),

              // Profile
              _buildItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: "Profile",
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // Navigation Item
  // =========================================================

  Widget _buildItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final bool isSelected =
        currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          onItemSelected(index);
        },

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              isSelected
                  ? selectedIcon
                  : icon,

              color: isSelected
                  ? const Color(0xFF52C070)
                  : Colors.grey,

              size: 22,
            ),

            const SizedBox(height: 4),

            Text(
              label,

              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF52C070)
                    : Colors.grey,

                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}