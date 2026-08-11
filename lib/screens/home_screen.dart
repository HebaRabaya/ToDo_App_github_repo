// =========================================================
// Home Screen
// =========================================================
//
// هاي الشاشة الرئيسية في Tasky.
//
// بتعرض:
// - اسم المستخدم
// - نسبة الإنجاز
// - High Priority Tasks
// - كل التاسكات
//
// بدل ما الشاشة تقرأ البيانات بنفسها من
// PreferencesManager.instance،
// بنخلي Provider يجيب البيانات إلنا.
//
// Consumer<PreferencesManager>
// بخلي الشاشة تسمع لأي تغيير يصير بالـ Controller.
//
// =========================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/preferences_manager.dart';
import '../widgets/achieved_tasks_widget.dart';
import '../widgets/high_priority_tasks_widget.dart';
import '../widgets/sliver_task_list_widget.dart';
import 'add_task_screen.dart';
import 'high_priority_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _openAddTask(
      BuildContext context,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const AddTaskScreen(),
      ),
    );
  }

  Future<void> _openHighPriority(
      BuildContext context,
      ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const HighPriorityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesManager>(
      builder: (
          context,
          manager,
          child,
          ) {
        final tasks =
            manager.tasks;

        final completedTasks =
            tasks
                .where(
                  (task) =>
              task.isCompleted,
            )
                .length;

        final totalTasks =
            tasks.length;

        final progress =
        totalTasks == 0
            ? 0.0
            : completedTasks /
            totalTasks;

        final highPriorityTasks =
        tasks
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

          floatingActionButton:
          FloatingActionButton.extended(
            backgroundColor:
            const Color(
              0xFF52C070,
            ),

            onPressed: () =>
                _openAddTask(context),

            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            label: const Text(
              "Add New Task",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // =================================================
                // Header
                // =================================================

                SliverPadding(
                  padding:
                  const EdgeInsets.fromLTRB(
                    15,
                    15,
                    15,
                    0,
                  ),

                  sliver:
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,

                          decoration:
                          BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                              8,
                            ),

                            border:
                            Border.all(
                              color:
                              const Color(
                                0xFF9747FF,
                              ),
                              width: 2,
                            ),
                          ),

                          child:
                          ClipRRect(
                            borderRadius:
                            BorderRadius
                                .circular(
                              6,
                            ),

                            child:
                            Image.asset(
                              "assets/images/profile.png",
                              fit:
                              BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 7,
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [
                              Text(
                                "Good Evening ${manager.username} 👋🏻",

                                style: theme
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  fontSize:
                                  13,
                                ),
                              ),

                              const SizedBox(
                                height: 2,
                              ),

                              Text(
                                "One task at a time. One step closer.",

                                style: theme
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  fontSize:
                                  11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // =================================================
                // Main Title
                // =================================================

                SliverPadding(
                  padding:
                  const EdgeInsets.fromLTRB(
                    15,
                    25,
                    15,
                    0,
                  ),

                  sliver:
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [
                        Text(
                          "Yuhuu, Your work Is",
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontSize: 23,
                          ),
                        ),

                        Text(
                          "almost done! 👋🏻",
                          style: theme
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // =================================================
                // Achieved Tasks
                // =================================================

                SliverPadding(
                  padding:
                  const EdgeInsets.fromLTRB(
                    15,
                    16,
                    15,
                    0,
                  ),

                  sliver:
                  SliverToBoxAdapter(
                    child:
                    AchievedTasksWidget(
                      completedTasks:
                      completedTasks,
                      totalTasks:
                      totalTasks,
                      progress:
                      progress,
                    ),
                  ),
                ),

                // =================================================
                // High Priority
                // =================================================

                if (highPriorityTasks
                    .isNotEmpty)
                  SliverPadding(
                    padding:
                    const EdgeInsets.fromLTRB(
                      15,
                      12,
                      15,
                      0,
                    ),

                    sliver:
                    SliverToBoxAdapter(
                      child:
                      HighPriorityTasksWidget(
                        tasks:
                        highPriorityTasks,

                        onViewAll: () =>
                            _openHighPriority(
                              context,
                            ),
                      ),
                    ),
                  ),

                // =================================================
                // My Tasks
                // =================================================

                SliverPadding(
                  padding:
                  const EdgeInsets.fromLTRB(
                    15,
                    18,
                    15,
                    8,
                  ),

                  sliver:
                  SliverToBoxAdapter(
                    child: Text(
                      "My Tasks",
                      style: theme
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                SliverTaskListWidget(
                  tasks: tasks,
                ),

                const SliverPadding(
                  padding:
                  EdgeInsets.only(
                    bottom: 100,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}