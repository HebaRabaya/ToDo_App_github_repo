import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';

// =========================================================
// Completed Tasks Screen
// =========================================================

// هاي الشاشة بتعرض التاسكات اللي خلصناها.
//
// الصفحة بتسمع لتغييرات PreferencesManager،
// عشان إذا Task صارت Completed أو رجعت To Do
// القائمة تتحدث مباشرة.
class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({
    super.key,
  });

  @override
  State<CompleteTasksScreen> createState() =>
      _CompleteTasksScreenState();
}

// =========================================================
// Logic
// =========================================================

class _CompleteTasksScreenState
    extends State<CompleteTasksScreen> {
  // التاسكات المكتملة.
  List tasks = [];

  // =======================================================
  // Init
  // =======================================================

  @override
  void initState() {
    super.initState();

    // تحميل التاسكات أول مرة.
    _loadTasks();

    // الاستماع لأي تغيير على التاسكات.
    PreferencesManager.instance.addListener(
      _loadTasks,
    );
  }

  // =======================================================
  // Dispose
  // =======================================================

  @override
  void dispose() {
    // إزالة الـ Listener لما الصفحة تنتهي.
    PreferencesManager.instance.removeListener(
      _loadTasks,
    );

    super.dispose();
  }

  // =======================================================
  // Load Completed Tasks
  // =======================================================

  void _loadTasks() {
    final allTasks =
        PreferencesManager.instance.tasks;

    final completedTasks = allTasks
        .where(
          (task) => task.isCompleted,
    )
        .toList();

    if (!mounted) return;

    setState(() {
      tasks = completedTasks;
    });
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ===================================================
      // App Bar
      // ===================================================

      appBar: AppBar(
        title: const Text(
          "Completed Tasks",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),

      // ===================================================
      // Body
      // ===================================================

      body: SafeArea(
        child: tasks.isEmpty
            ? Center(
          child: Text(
            "No completed tasks",
            style:
            theme.textTheme.bodySmall,
          ),
        )
            : ListView.builder(
          padding:
          const EdgeInsets.all(13),

          itemCount:
          tasks.length,

          itemBuilder:
              (context, index) {
            return TaskItemWidget(
              task: tasks[index],

              // لما حالة التاسك تتغير
              // بنعيد تحميل القائمة.
              onTaskUpdated:
              _loadTasks,
            );
          },
        ),
      ),
    );
  }
}