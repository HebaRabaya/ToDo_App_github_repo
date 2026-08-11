// =========================================================
// To Do Screen
// =========================================================
//
// هاي الشاشة بتعرض التاسكات اللي لسا ما خلصت.
//
// يعني:
// isCompleted == false
//
// إذا المستخدم عمل Task كـ Done:
// بتختفي من هون وتظهر في Completed.
//
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  // =======================================================
  // Add Task
  // =======================================================

  Future<void> _addTask(
      BuildContext context,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddTaskScreen(),
      ),
    );
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesManager>(
      builder: (
          context,
          manager,
          child,
          ) {
        // =================================================
        // To Do Tasks
        // =================================================
        //
        // بنعرض فقط التاسكات غير المكتملة.
        //
        final tasks = manager.tasks
            .where(
              (task) => !task.isCompleted,
        )
            .toList();

        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor:
          theme.scaffoldBackgroundColor,

          // =================================================
          // App Bar
          // =================================================

          appBar: AppBar(
            title: const Text(
              "To Do",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // =================================================
          // Add Task
          // =================================================

          floatingActionButton:
          FloatingActionButton.extended(
            onPressed: () => _addTask(context),

            backgroundColor:
            const Color(0xFF52C070),

            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            label: const Text(
              "Add Task",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // =================================================
          // Body
          // =================================================

          body: tasks.isEmpty
              ? Center(
            child: Padding(
              padding:
              const EdgeInsets.all(30),
              child: Column(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  Icon(
                    Icons
                        .check_circle_outline,
                    size: 55,
                    color:
                    theme.colorScheme
                        .primary,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    "You're all caught up!",
                    style: theme
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    "No tasks to do right now.",
                    textAlign:
                    TextAlign.center,
                    style: theme
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),
            ),
          )
              : ListView.builder(
            padding:
            const EdgeInsets.fromLTRB(
              15,
              12,
              15,
              100,
            ),

            itemCount:
            tasks.length,

            itemBuilder:
                (context, index) {
              return TaskItemWidget(
                task: tasks[index],
              );
            },
          ),
        );
      },
    );
  }
}