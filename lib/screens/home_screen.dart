import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';
import '../widgets/achieved_tasks_widget.dart';
import '../widgets/high_priority_tasks_widget.dart';
import '../widgets/sliver_task_list_widget.dart';
import 'add_task_screen.dart';
import 'high_priority_screen.dart';

// =========================================================
// Home Screen
// =========================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

// =========================================================
// Logic
// =========================================================

class _HomeScreenState
    extends State<HomeScreen> {
  List<TaskModel> tasks = [];

  String userName = "";

  // =======================================================
  // Init
  // =======================================================

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  // =======================================================
  // Load Data
  // =======================================================

  void _loadData() {
    final manager =
        PreferencesManager.instance;

    setState(() {
      userName =
          manager.username;

      tasks =
          manager.tasks;
    });
  }

  // =======================================================
  // Open Add Task
  // =======================================================

  Future<void> _openAddTask() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const AddTaskScreen(),
      ),
    );

    _loadData();
  }

  // =======================================================
  // Open High Priority
  // =======================================================

  Future<void>
  _openHighPriority() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const HighPriorityScreen(),
      ),
    );

    _loadData();
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    final completedTasks =
        tasks
            .where(
              (task) =>
          task.isCompleted,
        )
            .length;

    final totalTasks =
        tasks.length;

    final double progress =
    totalTasks == 0
        ? 0
        : completedTasks /
        totalTasks;

    final highPriorityTasks =
    tasks
        .where(
          (task) =>
      task.isHighPriority,
    )
        .toList();

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // =====================================================
      // Add Task Button
      // =====================================================

      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor:
        const Color(
          0xFF52C070,
        ),

        onPressed:
        _openAddTask,

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

      // =====================================================
      // Body
      // =====================================================

      body: SafeArea(
        child:
        CustomScrollView(
          slivers: [
            // =================================================
            // Header
            // =================================================

            SliverPadding(
              padding:
              const EdgeInsets
                  .fromLTRB(
                15,
                15,
                15,
                0,
              ),

              sliver:
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    // Profile Image
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

                    // User Name
                    Expanded(
                      child:
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          Text(
                            "Good Evening $userName 👋🏻",

                            style:
                            theme
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(
                            height: 2,
                          ),

                          Text(
                            "One task at a time. One step closer.",

                            style:
                            theme
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              fontSize: 11,
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
              const EdgeInsets
                  .fromLTRB(
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
              const EdgeInsets
                  .fromLTRB(
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
                const EdgeInsets
                    .fromLTRB(
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

                    onViewAll:
                    _openHighPriority,

                    onTaskUpdated:
                    _loadData,
                  ),
                ),
              ),

            // =================================================
            // My Tasks
            // =================================================

            SliverPadding(
              padding:
              const EdgeInsets
                  .fromLTRB(
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

            // =================================================
            // Tasks List
            // =================================================

            SliverTaskListWidget(
              tasks: tasks,

              onTaskChanged:
                  (_, __) {},

              onTaskUpdated:
              _loadData,
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
  }
}