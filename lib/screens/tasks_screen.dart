import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';

// =========================================================
// To Do Tasks Screen
// =========================================================

// هاي الشاشة بتعرض التاسكات اللي لسا ما خلصناها.
//
// الصفحة بتسمع لأي تغيير بصير داخل PreferencesManager.
// يعني لما نضيف أو نعدل أو نحذف Task، القائمة بتتحدث
// لحالها بدون ما نحتاج نرجع نفتح الصفحة.
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() =>
      _TasksScreenState();
}

// =========================================================
// Logic
// =========================================================

class _TasksScreenState extends State<TasksScreen> {
  // التاسكات غير المكتملة.
  List tasks = [];

  // =======================================================
  // Init
  // =======================================================

  @override
  void initState() {
    super.initState();

    // أول ما الصفحة تشتغل بنجيب التاسكات.
    _loadTasks();

    // بنخلي الصفحة تسمع لأي تغيير بصير على البيانات.
    PreferencesManager.instance.addListener(
      _loadTasks,
    );
  }

  // =======================================================
  // Dispose
  // =======================================================

  @override
  void dispose() {
    // مهم نشيل الـ Listener لما الصفحة تنتهي.
    // عشان ما يضل مربوط بالصفحة ويسبب مشاكل بالذاكرة.
    PreferencesManager.instance.removeListener(
      _loadTasks,
    );

    super.dispose();
  }

  // =======================================================
  // Load Tasks
  // =======================================================

  void _loadTasks() {
    final allTasks =
        PreferencesManager.instance.tasks;

    final todoTasks = allTasks
        .where(
          (task) => !task.isCompleted,
    )
        .toList();

    if (!mounted) return;

    setState(() {
      tasks = todoTasks;
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
          "To Do Tasks",
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
            "No tasks to do",
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
              // بنعيد قراءة القائمة.
              onTaskUpdated:
              _loadTasks,
            );
          },
        ),
      ),
    );
  }
}