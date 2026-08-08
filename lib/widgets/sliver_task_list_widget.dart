import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_list_widget.dart';

// =========================================================
// Sliver Task List Widget
// =========================================================

class SliverTaskListWidget
    extends StatelessWidget {

  final List<TaskModel> tasks;

  final Function(int index, bool value)
  onTaskChanged;

  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTaskChanged,
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

            child: TaskListWidget(
              task: task,

              onChanged: (value) {
                if (value != null) {
                  onTaskChanged(
                    index,
                    value,
                  );
                }
              },
            ),
          );
        },

        childCount:
        tasks.length,
      ),
    );
  }
}