import 'package:flutter/material.dart';

import '../models/task_model.dart';

// =========================================================
// High Priority Tasks Widget
// =========================================================

class HighPriorityTasksWidget
    extends StatelessWidget {

  final List<TaskModel>? tasks;

  final TaskModel? task;

  final Function(bool value)? onChanged;

  final Function(TaskModel task)? onTaskChanged;

  final VoidCallback? onViewAll;

  const HighPriorityTasksWidget({
    super.key,
    this.tasks,
    this.task,
    this.onChanged,
    this.onTaskChanged,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {

    // إذا تم تمرير Task واحدة
    if (task != null) {
      return _buildSingleTask(
        context,
        task!,
      );
    }

    // إذا ما في قائمة
    if (tasks == null ||
        tasks!.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

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
            MainAxisAlignment.spaceBetween,

            children: [

              Text(
                "High Priority",
                style:
                theme.textTheme.bodyMedium
                    ?.copyWith(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),

              TextButton(
                onPressed: onViewAll,

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

          const SizedBox(height: 4),

          // =================================================
          // Tasks
          // =================================================

          ...tasks!.take(3).map(
                (task) {
              return _buildSingleTask(
                context,
                task,
              );
            },
          ),
        ],
      ),
    );
  }

  // =========================================================
  // Single Task
  // =========================================================

  Widget _buildSingleTask(
      BuildContext context,
      TaskModel task,
      ) {
    final theme = Theme.of(context);

    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 6,
      ),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 3,
      ),

      child: Row(
        children: [

          Checkbox(
            value: task.isCompleted,

            onChanged: (value) {
              if (value != null) {
                onChanged?.call(value);

                onTaskChanged
                    ?.call(task);
              }
            },

            activeColor:
            const Color(
              0xFF00D084,
            ),

            visualDensity:
            VisualDensity.compact,
          ),

          Expanded(
            child: Text(
              task.taskName,

              maxLines: 1,

              overflow:
              TextOverflow.ellipsis,

              style:
              theme.textTheme.bodyMedium
                  ?.copyWith(
                fontSize: 11,

                decoration:
                task.isCompleted
                    ? TextDecoration
                    .lineThrough
                    : null,
              ),
            ),
          ),

          const Icon(
            Icons.flag,
            color:
            Color(0xFF52C070),
            size: 15,
          ),
        ],
      ),
    );
  }
}