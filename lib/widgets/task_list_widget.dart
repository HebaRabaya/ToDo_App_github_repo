import 'package:flutter/material.dart';

import '../models/task_model.dart';

// =========================================================
// Task List Widget
// =========================================================

// هذا الـ Widget بعرض Task واحدة
class TaskListWidget
    extends StatelessWidget {

  final TaskModel task;

  final VoidCallback? onTap;

  final ValueChanged<bool?>? onChanged;

  const TaskListWidget({
    super.key,
    required this.task,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 7,
      ),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius:
        BorderRadius.circular(13),
      ),

      child: Row(
        children: [

          // =================================================
          // Checkbox
          // =================================================

          Checkbox(
            value: task.isCompleted,

            onChanged: onChanged,

            activeColor:
            const Color(
              0xFF00D084,
            ),

            checkColor:
            Colors.white,

            side: BorderSide(
              color: theme.brightness ==
                  Brightness.dark
                  ? Colors.white54
                  : Colors.black38,
            ),

            visualDensity:
            VisualDensity.compact,
          ),

          // =================================================
          // Task Information
          // =================================================

          Expanded(
            child: GestureDetector(
              onTap: onTap,

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // اسم التاسك
                  Text(
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

                  // الوصف
                  if (task.taskDescription
                      .isNotEmpty)
                    Text(
                      task.taskDescription,

                      maxLines: 1,

                      overflow:
                      TextOverflow.ellipsis,

                      style:
                      theme.textTheme.bodySmall
                          ?.copyWith(
                        fontSize: 9,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // =================================================
          // High Priority Indicator
          // =================================================

          if (task.isHighPriority)
            const Icon(
              Icons.flag,
              color:
              Color(0xFF52C070),
              size: 15,
            ),

          const SizedBox(width: 5),

          // More icon
          Icon(
            Icons.more_vert,

            color: theme.brightness ==
                Brightness.dark
                ? const Color(
              0xFF858585,
            )
                : const Color(
              0xFF777777,
            ),

            size: 18,
          ),
        ],
      ),
    );
  }
}