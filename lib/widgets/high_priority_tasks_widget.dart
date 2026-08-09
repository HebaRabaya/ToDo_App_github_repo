import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

// =========================================================
// High Priority Tasks Widget
// =========================================================

// هذا الـ Widget بعرض قسم High Priority في الـ Home.
class HighPriorityTasksWidget
    extends StatelessWidget {
  final List<TaskModel> tasks;

  final VoidCallback? onViewAll;

  final VoidCallback? onTaskUpdated;

  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    this.onViewAll,
    this.onTaskUpdated,
  });

  @override
  Widget build(BuildContext context) {
    // إذا ما في High Priority Tasks
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme =
    Theme.of(context);

    return Container(
      width:
      double.infinity,

      padding:
      const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius:
        BorderRadius.circular(15),
      ),

      child: Column(
        children: [
          // =================================================
          // Header
          // =================================================

          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [
              Text(
                "High Priority",

                style: theme
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),

              TextButton(
                onPressed:
                onViewAll,

                child: const Text(
                  "View All",

                  style: TextStyle(
                    color:
                    Color(0xFF52C070),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 4,
          ),

          // =================================================
          // Tasks
          // =================================================

          ...tasks
              .take(3)
              .map(
                (task) =>
                TaskItemWidget(
                  task: task,
                  onTaskUpdated:
                  onTaskUpdated,
                ),
          ),
        ],
      ),
    );
  }
}