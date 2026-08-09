import 'package:flutter/material.dart';

// =========================================================
// Achieved Tasks Widget
// =========================================================

// هذا الـ Widget بعرض:
// - عدد التاسكات المكتملة
// - العدد الكلي
// - نسبة الإنجاز
class AchievedTasksWidget
    extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final double progress;

  const AchievedTasksWidget({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    final percentage =
    (progress * 100).toInt();

    return Container(
      width:
      double.infinity,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius:
        BorderRadius.circular(15),
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [
          Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,

            children: [
              Text(
                "Achieved Tasks",

                style: theme
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  fontSize: 13,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                "$completedTasks Out of $totalTasks Done",

                style: theme
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),

          // =================================================
          // Progress
          // =================================================

          SizedBox(
            width: 40,
            height: 40,

            child: Stack(
              alignment:
              Alignment.center,

              children: [
                CircularProgressIndicator(
                  value:
                  progress,

                  strokeWidth: 2,

                  backgroundColor:
                  theme.brightness ==
                      Brightness.dark
                      ? const Color(
                    0xFF4A4A4A,
                  )
                      : const Color(
                    0xFFE0E0E0,
                  ),

                  color:
                  const Color(
                    0xFF00D084,
                  ),
                ),

                Text(
                  "$percentage%",

                  style: theme
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}