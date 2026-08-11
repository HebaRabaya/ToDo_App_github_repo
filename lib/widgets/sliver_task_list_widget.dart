// =========================================================
// Sliver Task List Widget
// =========================================================
//
// هذا Widget بعرض كل التاسكات داخل
// CustomScrollView باستخدام SliverList.
//
// بدل ما نكرر كود TaskItemWidget في Home.
// =========================================================

import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

class SliverTaskListWidget
    extends StatelessWidget {
  final List<TaskModel> tasks;

  const SliverTaskListWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            ),
          ),
        ),
      );
    }

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

            child:
            TaskItemWidget(
              task: task,
            ),
          );
        },

        childCount:
        tasks.length,
      ),
    );
  }
}