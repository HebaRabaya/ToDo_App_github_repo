// =========================================================
// Task List Widget
// =========================================================
//
// هذا Widget بسيط وظيفته يعرض Task واحدة
// باستخدام TaskItemWidget.
//
// وجوده بيساعدنا ما نكرر نفس UI
// في أكثر من مكان.
//
// =========================================================

import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

class TaskListWidget
    extends StatelessWidget {
  final TaskModel task;

  const TaskListWidget({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return TaskItemWidget(
      task: task,
    );
  }
}