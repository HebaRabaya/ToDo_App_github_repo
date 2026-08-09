import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';

// =========================================================
// High Priority Screen
// =========================================================

// هاي الشاشة بتعرض كل التاسكات اللي عليها
// High Priority.
//
// الصفحة بتسمع لأي تغيير بصير على PreferencesManager
// عشان القائمة تضل محدثة دائمًا.
class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({
    super.key,
  });

  @override
  State<HighPriorityScreen> createState() =>
      _HighPriorityScreenState();
}

// =========================================================
// Logic
// =========================================================

class _HighPriorityScreenState
    extends State<HighPriorityScreen> {
  // التاسكات ذات الأولوية العالية.
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
  // Load High Priority Tasks
  // =======================================================

  void _loadTasks() {
    final allTasks =
        PreferencesManager.instance.tasks;

    final highPriorityTasks = allTasks
        .where(
          (task) => task.isHighPriority,
    )
        .toList();

    if (!mounted) return;

    setState(() {
      tasks = highPriorityTasks;
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
          "High Priority Tasks",
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
            "No high priority tasks",
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

              // لما التاسك تتعدل
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