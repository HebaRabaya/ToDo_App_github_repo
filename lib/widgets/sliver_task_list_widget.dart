import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

// =========================================================
// Sliver Task List Widget
// =========================================================

// هذا الـ Widget بعرض التاسكات داخل CustomScrollView
// باستخدام SliverList.
class SliverTaskListWidget
    extends StatelessWidget {
  final List<TaskModel> tasks;

  final Function(int index, bool value)
  onTaskChanged;

  final VoidCallback? onTaskUpdated;

  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTaskChanged,
    this.onTaskUpdated,
  });

  @override
  Widget build(BuildContext context) {
    // إذا ما في Tasks
    if (tasks.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(
            vertical: 30,
          ),
          child: Center(
            child: Text(
              "No tasks yet",
              style:
              Theme.of(context)
                  .textTheme
                  .bodySmall,
            ),
          ),
        ),
      );
    }

    // إذا في Tasks
    return SliverList(
      delegate:
      SliverChildBuilderDelegate(
            (context, index) {
          final task =
          tasks[index];

          return Padding(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 15,
            ),

            child: TaskItemWidget(
              task: task,

              onTaskUpdated:
              onTaskUpdated,
            ),
          );
        },

        childCount:
        tasks.length,
      ),
    );
  }
}