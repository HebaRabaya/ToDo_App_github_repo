// =========================================================
// Complete Tasks Screen
// =========================================================
//
// هاي الشاشة بتعرض بس التاسكات اللي خلصت.
//
// Provider بجيب قائمة التاسكات،
// وإحنا بنفلتر اللي isCompleted = true.
//
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/task_item_widget.dart';

class CompleteTasksScreen
    extends StatelessWidget {
  const CompleteTasksScreen({
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
        final completedTasks =
        manager.tasks
            .where(
              (task) =>
          task.isCompleted,
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
              "Completed Tasks",
            ),
          ),

          body:
          completedTasks.isEmpty
              ? Center(
            child: Text(
              "No completed tasks yet",
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
            completedTasks
                .length,

            itemBuilder:
                (context, index) {
              return TaskItemWidget(
                task:
                completedTasks[
                index],
              );
            },
          ),
        );
      },
    );
  }
}