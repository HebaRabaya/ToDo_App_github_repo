import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/enums/task_item_actions_enum.dart';
import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

// =========================================================
// Task Item Widget
// =========================================================

// هذا الـ Widget مسؤول عن عرض Task واحدة.
//
// ومن هون المستخدم بقدر:
// - يعمل Complete
// - يعمل Edit
// - يعمل Delete
// - يغير Priority
// - يختار Date
// - يضيف صورة
class TaskItemWidget extends StatefulWidget {
  final TaskModel task;

  // بعد أي تعديل بنرجع للـ Parent
  // عشان يعمل Refresh.
  final VoidCallback? onTaskUpdated;

  const TaskItemWidget({
    super.key,
    required this.task,
    this.onTaskUpdated,
  });

  @override
  State<TaskItemWidget> createState() =>
      _TaskItemWidgetState();
}

// =========================================================
// Task Item Logic
// =========================================================

class _TaskItemWidgetState
    extends State<TaskItemWidget> {
  // =======================================================
  // Task Actions
  // =======================================================

  Future<void> _handleTaskAction(
      TaskItemActions action,
      ) async {
    switch (action) {
      case TaskItemActions.edit:
        await _editTask();
        break;

      case TaskItemActions.delete:
        await _deleteTask();
        break;

      case TaskItemActions.toggleComplete:
        await _toggleTaskStatus();
        break;
    }
  }

  // =======================================================
  // Toggle Complete
  // =======================================================

  Future<void> _toggleTaskStatus() async {
    final updatedTask =
    widget.task.copyWith(
      isCompleted:
      !widget.task.isCompleted,
    );

    await PreferencesManager.instance
        .updateTask(updatedTask);

    widget.onTaskUpdated?.call();
  }

  // =======================================================
  // Delete Task
  // =======================================================

  Future<void> _deleteTask() async {
    final shouldDelete =
    await _showDeleteDialog();

    if (!shouldDelete) {
      return;
    }

    await PreferencesManager.instance
        .deleteTask(
      widget.task.taskId,
    );

    widget.onTaskUpdated?.call();

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Task deleted successfully",
        ),
      ),
    );
  }

  // =======================================================
  // Delete Confirmation Dialog
  // =======================================================

  Future<bool> _showDeleteDialog() async {
    final theme = Theme.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
          theme.dialogBackgroundColor,

          title: Text(
            "Delete Task?",
            style:
            theme.textTheme.titleLarge,
          ),

          content: Text(
            "Are you sure you want to delete this task?",
            style:
            theme.textTheme.bodyMedium,
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                "Delete",
              ),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  // =======================================================
  // Edit Task
  // =======================================================

  Future<void> _editTask() async {
    final updatedTask =
    await showModalBottomSheet<TaskModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _EditTaskSheet(
          task: widget.task,
        );
      },
    );

    if (updatedTask == null) {
      return;
    }

    await PreferencesManager.instance
        .updateTask(updatedTask);

    widget.onTaskUpdated?.call();
  }

  // =======================================================
  // Task Image
  // =======================================================

  Widget _buildTaskImage(
      BuildContext context,
      ) {
    final theme = Theme.of(context);

    final imagePath =
        widget.task.imagePath;

    if (imagePath == null ||
        imagePath.isEmpty ||
        !File(imagePath).existsSync()) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding:
      const EdgeInsets.only(
        right: 8,
      ),
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(8),
        child: Image.file(
          File(imagePath),
          width: 42,
          height: 42,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) {
            return Container(
              width: 42,
              height: 42,
              color: theme.cardColor,
            );
          },
        ),
      ),
    );
  }

  // =======================================================
  // Build
  // =======================================================

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
        vertical: 5,
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
            value: widget.task.isCompleted,

            onChanged: (_) {
              _toggleTaskStatus();
            },

            activeColor:
            const Color(0xFF00D084),

            checkColor:
            Colors.white,

            side: BorderSide(
              color:
              theme.brightness ==
                  Brightness.dark
                  ? Colors.white54
                  : Colors.black38,
            ),

            visualDensity:
            VisualDensity.compact,
          ),

          // =================================================
          // Image
          // =================================================

          _buildTaskImage(context),

          // =================================================
          // Task Information
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.taskName,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  theme.textTheme.bodyMedium
                      ?.copyWith(
                    fontSize: 11,
                    decoration:
                    widget.task.isCompleted
                        ? TextDecoration
                        .lineThrough
                        : null,
                  ),
                ),

                if (widget.task.taskDescription
                    .isNotEmpty)
                  Text(
                    widget.task.taskDescription,

                    maxLines: 1,

                    overflow:
                    TextOverflow.ellipsis,

                    style:
                    theme.textTheme.bodySmall
                        ?.copyWith(
                      fontSize: 9,
                    ),
                  ),

                if (widget.task.dueDate !=
                    null)
                  Text(
                    "Due: ${widget.task.dueDate}",

                    style:
                    theme.textTheme.bodySmall
                        ?.copyWith(
                      fontSize: 8,
                    ),
                  ),
              ],
            ),
          ),

          // =================================================
          // High Priority
          // =================================================

          if (widget.task.isHighPriority)
            const Icon(
              Icons.flag,
              color:
              Color(0xFF52C070),
              size: 15,
            ),

          // =================================================
          // Popup Menu
          // =================================================

          PopupMenuButton<
              TaskItemActions>(
            icon: Icon(
              Icons.more_vert,
              color:
              theme.iconTheme.color,
              size: 18,
            ),

            color:
            theme.cardColor,

            onSelected:
            _handleTaskAction,

            itemBuilder:
                (context) {
              return [
                PopupMenuItem(
                  value:
                  TaskItemActions.edit,

                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      const Text(
                        "Edit",
                      ),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value:
                  TaskItemActions
                      .toggleComplete,

                  child: Row(
                    children: [
                      Icon(
                        widget.task
                            .isCompleted
                            ? Icons
                            .undo_outlined
                            : Icons
                            .check_circle_outline,
                        size: 18,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Text(
                        widget.task
                            .isCompleted
                            ? "Mark as Undone"
                            : "Mark as Done",
                      ),
                    ],
                  ),
                ),

                PopupMenuItem(
                  value:
                  TaskItemActions.delete,

                  child: Row(
                    children: [
                      const Icon(
                        Icons
                            .delete_outline,
                        size: 18,
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      const Text(
                        "Delete",
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

// =========================================================
// Edit Task Bottom Sheet
// =========================================================

// هذا الـ Widget مسؤول عن شاشة تعديل التاسك
// اللي بتظهر من تحت.
class _EditTaskSheet
    extends StatefulWidget {
  final TaskModel task;

  const _EditTaskSheet({
    required this.task,
  });

  @override
  State<_EditTaskSheet> createState() =>
      _EditTaskSheetState();
}

// =========================================================
// Edit Task Sheet Logic
// =========================================================

class _EditTaskSheetState
    extends State<_EditTaskSheet> {
  // =======================================================
  // Controllers
  // =======================================================

  late final TextEditingController
  _titleController;

  late final TextEditingController
  _descriptionController;

  // =======================================================
  // State
  // =======================================================

  late bool _isHighPriority;

  String? _selectedDate;

  String? _imagePath;

  final ImagePicker _imagePicker =
  ImagePicker();

  // =======================================================
  // Init
  // =======================================================

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(
          text: widget.task.taskName,
        );

    _descriptionController =
        TextEditingController(
          text: widget.task.taskDescription,
        );

    _isHighPriority =
        widget.task.isHighPriority;

    _selectedDate =
        widget.task.dueDate;

    _imagePath =
        widget.task.imagePath;
  }

  // =======================================================
  // Dispose
  // =======================================================

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  // =======================================================
  // Pick Date
  // =======================================================

  Future<void> _pickDate() async {
    final theme =
    Theme.of(context);

    final now = DateTime.now();

    DateTime initialDate =
        now;

    if (_selectedDate != null) {
      final parsedDate =
      DateTime.tryParse(
        _selectedDate!,
      );

      if (parsedDate != null) {
        initialDate =
            parsedDate;
      }
    }

    final pickedDate =
    await showDatePicker(
      context: context,

      initialDate:
      initialDate.isBefore(now)
          ? now
          : initialDate,

      firstDate: now,

      lastDate: DateTime(
        now.year + 10,
      ),

      builder:
          (context, child) {
        return Theme(
          data: theme,
          child: child!,
        );
      },
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate =
      "${pickedDate.year}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";
    });
  }

  // =======================================================
  // Pick Image
  // =======================================================

  Future<void> _pickImage() async {
    final image =
    await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _imagePath = image.path;
    });
  }

  // =======================================================
  // Remove Image
  // =======================================================

  void _removeImage() {
    setState(() {
      _imagePath = null;
    });
  }

  // =======================================================
  // Save Changes
  // =======================================================

  void _saveChanges() {
    final taskName =
    _titleController.text.trim();

    // Validation
    if (taskName.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a task name",
          ),
        ),
      );

      return;
    }

    final updatedTask =
    widget.task.copyWith(
      taskName: taskName,

      taskDescription:
      _descriptionController.text
          .trim(),

      isHighPriority:
      _isHighPriority,

      dueDate:
      _selectedDate,

      imagePath:
      _imagePath,

      clearDueDate:
      _selectedDate == null,

      clearImagePath:
      _imagePath == null,
    );

    Navigator.pop(
      context,
      updatedTask,
    );
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    final bottomInset =
        MediaQuery.of(context)
            .viewInsets
            .bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.55,
      maxChildSize: 0.95,

      expand: false,

      builder:
          (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color:
            theme.scaffoldBackgroundColor,

            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),

          child: SingleChildScrollView(
            controller:
            scrollController,

            padding:
            EdgeInsets.fromLTRB(
              16,
              12,
              16,
              20 + bottomInset,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                // =================================================
                // Drag Handle
                // =================================================

                Center(
                  child: Container(
                    width: 40,
                    height: 4,

                    decoration:
                    BoxDecoration(
                      color:
                      theme.dividerColor,
                      borderRadius:
                      BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                // =================================================
                // Title
                // =================================================

                Text(
                  "Edit Task",
                  style:
                  theme.textTheme
                      .titleLarge,
                ),

                const SizedBox(
                  height: 20,
                ),

                // =================================================
                // Task Name
                // =================================================

                Text(
                  "Task Name",
                  style:
                  theme.textTheme
                      .bodyMedium,
                ),

                const SizedBox(
                  height: 8,
                ),

                TextField(
                  controller:
                  _titleController,

                  decoration:
                  const InputDecoration(
                    hintText:
                    "Enter task name",
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // =================================================
                // Description
                // =================================================

                Text(
                  "Task Description",
                  style:
                  theme.textTheme
                      .bodyMedium,
                ),

                const SizedBox(
                  height: 8,
                ),

                TextField(
                  controller:
                  _descriptionController,

                  maxLines: 4,

                  decoration:
                  const InputDecoration(
                    hintText:
                    "Enter task description",
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                // =================================================
                // High Priority
                // =================================================

                SwitchListTile(
                  contentPadding:
                  EdgeInsets.zero,

                  title: const Text(
                    "High Priority",
                  ),

                  value:
                  _isHighPriority,

                  onChanged: (value) {
                    setState(() {
                      _isHighPriority =
                          value;
                    });
                  },
                ),

                const Divider(),

                // =================================================
                // Date Picker
                // =================================================

                ListTile(
                  contentPadding:
                  EdgeInsets.zero,

                  leading: const Icon(
                    Icons.calendar_today_outlined,
                  ),

                  title: const Text(
                    "Due Date",
                  ),

                  subtitle:
                  _selectedDate == null
                      ? const Text(
                    "No date selected",
                  )
                      : Text(
                    _selectedDate!,
                  ),

                  trailing:
                  _selectedDate == null
                      ? const Icon(
                    Icons
                        .arrow_forward_ios,
                    size: 16,
                  )
                      : IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed:
                        () {
                      setState(() {
                        _selectedDate =
                        null;
                      });
                    },
                  ),

                  onTap: _pickDate,
                ),

                const Divider(),

                // =================================================
                // Image Picker
                // =================================================

                ListTile(
                  contentPadding:
                  EdgeInsets.zero,

                  leading: const Icon(
                    Icons.image_outlined,
                  ),

                  title: const Text(
                    "Task Image",
                  ),

                  subtitle:
                  _imagePath == null
                      ? const Text(
                    "Choose an image",
                  )
                      : const Text(
                    "Image selected",
                  ),

                  trailing:
                  _imagePath == null
                      ? const Icon(
                    Icons
                        .arrow_forward_ios,
                    size: 16,
                  )
                      : IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                    onPressed:
                    _removeImage,
                  ),

                  onTap: _pickImage,
                ),

                if (_imagePath != null &&
                    File(_imagePath!)
                        .existsSync())
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 8,
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                        12,
                      ),
                      child: Image.file(
                        File(_imagePath!),
                        width:
                        double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 22,
                ),

                // =================================================
                // Save Button
                // =================================================

                SizedBox(
                  width:
                  double.infinity,

                  height: 48,

                  child: ElevatedButton(
                    onPressed:
                    _saveChanges,

                    child: const Text(
                      "Save Changes",
                    ),
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