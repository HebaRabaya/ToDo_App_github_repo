// =========================================================
// High Priority Screen
// =========================================================
//
// هاي الشاشة بتعرض التاسكات اللي عليها
// High Priority فقط.
//
// البيانات بتيجي من Provider.
//
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';

class HighPriorityScreen
    extends StatelessWidget {
  const HighPriorityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesManager>(
      builder: (
          context,
          manager,
          child,
          ) {
        final tasks =
        manager.tasks
            .where(
              (task) =>
          task.isHighPriority,
        )
            .toList();

        final theme =
        Theme.of(context);

        return Scaffold(
          backgroundColor:
          theme.scaffoldBackgroundColor,

          appBar: AppBar(
            title:
            const Text(
              "High Priority",
            ),
          ),

          body: tasks.isEmpty
              ? Center(
            child: Text(
              "No high priority tasks",
              style: theme
                  .textTheme
                  .bodySmall,
            ),
          )
              : ListView.builder(
            padding:
            const EdgeInsets
                .fromLTRB(
              15,
              10,
              15,
              30,
            ),

            itemCount:
            tasks.length,

            itemBuilder:
                (context, index) {
              return TaskItemWidget(
                task:
                tasks[index],
              );
            },
          ),
        );
      },
    );
  }
}