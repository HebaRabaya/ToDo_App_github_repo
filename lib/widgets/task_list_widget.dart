import 'package:flutter/material.dart';

import '../models/task_model.dart';
import 'task_item_widget.dart';

// =========================================================
// Task List Widget
// =========================================================

// هذا الـ Widget مسؤول عن وضع Task داخل القائمة.
//
// UI الأساسي للتاسك موجود في:
// TaskItemWidget
//
// عشان ما نكرر نفس الكود بأكثر من مكان.
class TaskListWidget extends StatelessWidget {
  final TaskModel task;

  final VoidCallback? onTaskUpdated;

  const TaskListWidget({
    super.key,
    required this.task,
    this.onTaskUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return TaskItemWidget(
      task: task,
      onTaskUpdated: onTaskUpdated,
    );
  }
}