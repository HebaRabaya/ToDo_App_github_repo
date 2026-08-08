import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _HomeScreenState extends State<HomeScreen> {

  List<TaskModel> tasks = [];

  String userName = "";

  // =========================================================
  // بداية الشاشة
  // =========================================================

  @override
  void initState() {
    super.initState();

    loadUserName();
    loadTasks();
  }

  // =========================================================
  // قراءة اسم المستخدم
  // =========================================================

  Future<void> loadUserName() async {
    final pref =
    await SharedPreferences.getInstance();

    final savedName =
        pref.getString("username") ?? "";

    if (!mounted) return;

    setState(() {
      userName = savedName;
    });
  }

  // =========================================================
  // قراءة التاسكات
  // =========================================================

  Future<void> loadTasks() async {
    final pref =
    await SharedPreferences.getInstance();

    final savedTasks =
        pref.getStringList("tasks") ?? [];

    final List<TaskModel> loadedTasks = [];

    for (final task in savedTasks) {
      try {
        final decoded = jsonDecode(task);

        loadedTasks.add(
          TaskModel.fromJson(
            Map<String, dynamic>.from(decoded),
          ),
        );
      } catch (e) {
        // إذا في Task فيها مشكلة
      }
    }

    if (!mounted) return;

    setState(() {
      tasks = loadedTasks;
    });
  }

  // =========================================================
  // حفظ التاسكات
  // =========================================================

  Future<void> saveTasks() async {
    final pref =
    await SharedPreferences.getInstance();

    final encodedTasks = tasks
        .map(
          (task) => jsonEncode(
        task.toJson(),
      ),
    )
        .toList();

    await pref.setStringList(
      "tasks",
      encodedTasks,
    );
  }

  // =========================================================
  // تغيير حالة التاسك
  // =========================================================

  Future<void> changeTaskStatus(
      int index,
      bool value,
      ) async {
    setState(() {
      tasks[index] =
          tasks[index].copyWith(
            isCompleted: value,
          );
    });

    await saveTasks();
  }

  // =========================================================
  // Build
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final completedTasks = tasks
        .where((task) => task.isCompleted)
        .length;

    final totalTasks = tasks.length;

    final double progress =
    totalTasks == 0
        ? 0
        : completedTasks / totalTasks;

    final highPriorityTasks = tasks
        .where(
          (task) => task.isHighPriority,
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
        const Color(0xFF52C070),

        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const AddTaskScreen(),
            ),
          );

          await loadTasks();
        },

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

                    // صورة البروفايل
                    Container(
                      width: 44,
                      height: 44,

                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                          8,
                        ),

                        border: Border.all(
                          color:
                          const Color(
                            0xFF9747FF,
                          ),
                          width: 2,
                        ),
                      ),

                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(
                          6,
                        ),

                        child: Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 7,
                    ),

                    // اسم المستخدم
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          Text(
                            "Good Evening $userName 👋🏻",
                            style:
                            theme.textTheme
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
                            theme.textTheme
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
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Yuhuu, Your work Is",
                      style:
                      theme.textTheme
                          .titleMedium
                          ?.copyWith(
                        fontSize: 23,
                      ),
                    ),

                    Text(
                      "almost done! 👋🏻",
                      style:
                      theme.textTheme
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

            if (highPriorityTasks.isNotEmpty)
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

                    onTaskChanged:
                        (task) {
                      final index =
                      tasks.indexOf(
                        task,
                      );

                      if (index != -1) {
                        changeTaskStatus(
                          index,
                          !task.isCompleted,
                        );
                      }
                    },

                    onViewAll:
                        () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const HighPriorityScreen(),
                        ),
                      );

                      await loadTasks();
                    },
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
                  style:
                  theme.textTheme.bodyMedium
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
                  (index, value) {
                changeTaskStatus(
                  index,
                  value,
                );
              },
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