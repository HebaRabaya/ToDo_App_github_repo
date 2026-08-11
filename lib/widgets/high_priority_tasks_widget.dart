// =========================================================
// High Priority Tasks Widget
// =========================================================
//
// هذا Widget مسؤول عن عرض قسم High Priority
// داخل Home Screen.
//
// بياخذ التاسكات من الـ Home
// وبعرض أول 3 Tasks فقط.
//
// =========================================================

import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

class HighPriorityTasksWidget
    extends StatelessWidget {
  final List<TaskModel> tasks;

  final VoidCallback? onViewAll;

  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
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

      decoration:
      BoxDecoration(
        color: theme.cardColor,

        borderRadius:
        BorderRadius.circular(
          15,
        ),
      ),

      child: Column(
        children: [
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

                child:
                const Text(
                  "View All",
                  style:
                  TextStyle(
                    color:
                    Color(
                      0xFF52C070,
                    ),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 4,
          ),

          ...tasks
              .take(3)
              .map(
                (task) =>
                TaskItemWidget(
                  task: task,
                ),
          ),
        ],
      ),
    );
  }
}