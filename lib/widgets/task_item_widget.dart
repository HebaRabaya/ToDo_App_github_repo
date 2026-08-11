// =========================================================
// Task Item Widget
// =========================================================
//
// هذا Widget مسؤول عن عرض Task واحدة.
//
// المستخدم بقدر من هون:
// - يعمل Complete
// - يرجعها Undone
// - يعمل Edit
// - يعمل Delete
//
// البيانات نفسها محفوظة عن طريق
// PreferencesManager الموجود مع Provider.
//
// =========================================================

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;

  const TaskItemWidget({
    super.key,
    required this.task,
  });

  // =======================================================
  // Toggle Complete
  // =======================================================

  Future<void> _toggleTaskStatus(
      BuildContext context,
      ) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
    );

    await context
        .read<PreferencesManager>()
        .updateTask(updatedTask);
  }

  // =======================================================
  // Delete
  // =======================================================

  Future<void> _deleteTask(
      BuildContext context,
      ) async {
    final shouldDelete =
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final theme =
        Theme.of(dialogContext);

        return AlertDialog(
          backgroundColor:
          theme.cardColor,

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(18),
          ),

          title: const Text(
            "Delete Task?",
          ),

          content: const Text(
            "Are you sure you want to delete this task?",
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
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
                  dialogContext,
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

    if (shouldDelete != true) {
      return;
    }

    await context
        .read<PreferencesManager>()
        .deleteTask(
      task.taskId,
    );

    if (!context.mounted) return;

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
  // Edit
  // =======================================================

  Future<void> _editTask(
      BuildContext context,
      ) async {
    final result =
    await showModalBottomSheet<TaskModel>(
      context: context,

      isScrollControlled: true,

      backgroundColor:
      Colors.transparent,

      builder: (_) {
        return _EditTaskSheet(
          task: task,
        );
      },
    );

    if (result == null) {
      return;
    }

    await context
        .read<PreferencesManager>()
        .updateTask(result);
  }

  // =======================================================
  // Popup Menu
  // =======================================================

  void _handleMenuAction(
      BuildContext context,
      String value,
      ) {
    switch (value) {
      case "edit":
        _editTask(context);
        break;

      case "toggle":
        _toggleTaskStatus(context);
        break;

      case "delete":
        _deleteTask(context);
        break;
    }
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    final theme =
    Theme.of(context);

    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),

      decoration:
      BoxDecoration(
        color: theme.cardColor,

        borderRadius:
        BorderRadius.circular(
          16,
        ),

        border: Border.all(
          color: theme.dividerColor
              .withValues(alpha: 0.15),
        ),
      ),

      child: Row(
        children: [
          // =================================================
          // Checkbox
          // =================================================

          Checkbox(
            value:
            task.isCompleted,

            onChanged: (_) =>
                _toggleTaskStatus(
                  context,
                ),

            activeColor:
            const Color(0xFF52C070),

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                5,
              ),
            ),
          ),

          // =================================================
          // Image
          // =================================================

          if (task.imagePath != null &&
              task.imagePath!.isNotEmpty &&
              File(task.imagePath!)
                  .existsSync())
            Padding(
              padding:
              const EdgeInsets.only(
                right: 9,
              ),

              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                  9,
                ),

                child: Image.file(
                  File(
                    task.imagePath!,
                  ),

                  width: 45,
                  height: 45,

                  fit: BoxFit.cover,
                ),
              ),
            ),

          // =================================================
          // Task Information
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.taskName,

                        maxLines: 1,

                        overflow:
                        TextOverflow
                            .ellipsis,

                        style: theme
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontWeight:
                          FontWeight.w600,

                          decoration:
                          task.isCompleted
                              ? TextDecoration
                              .lineThrough
                              : null,

                          decorationThickness:
                          1.5,
                        ),
                      ),
                    ),

                    // Priority
                    if (task
                        .isHighPriority)
                      const Padding(
                        padding:
                        EdgeInsets.only(
                          left: 5,
                        ),
                        child: Icon(
                          Icons.flag_rounded,
                          size: 16,
                          color:
                          Color(0xFF52C070),
                        ),
                      ),
                  ],
                ),

                if (task.taskDescription
                    .isNotEmpty)
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 3,
                    ),
                    child: Text(
                      task.taskDescription,

                      maxLines: 1,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style: theme
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        fontSize: 11,
                      ),
                    ),
                  ),

                if (task.dueDate != null)
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons
                              .calendar_today_outlined,
                          size: 12,
                          color: theme
                              .textTheme
                              .bodySmall
                              ?.color,
                        ),

                        const SizedBox(
                          width: 4,
                        ),

                        Text(
                          task.dueDate!,

                          style: theme
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // =================================================
          // Three Dots
          // =================================================

          PopupMenuButton<String>(
            tooltip: "Task options",

            icon: Icon(
              Icons.more_vert_rounded,
              color:
              theme.iconTheme.color,
            ),

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                14,
              ),
            ),

            onSelected: (value) {
              _handleMenuAction(
                context,
                value,
              );
            },

            itemBuilder:
                (context) => [
              // Edit
              const PopupMenuItem(
                value: "edit",
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 19,
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Text("Edit"),
                  ],
                ),
              ),

              // Done / Undone
              PopupMenuItem(
                value: "toggle",

                child: Row(
                  children: [
                    Icon(
                      task.isCompleted
                          ? Icons
                          .undo_outlined
                          : Icons
                          .check_circle_outline,
                      size: 19,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Text(
                      task.isCompleted
                          ? "Mark as Undone"
                          : "Mark as Done",
                    ),
                  ],
                ),
              ),

              // Delete
              const PopupMenuItem(
                value: "delete",

                child: Row(
                  children: [
                    Icon(
                      Icons
                          .delete_outline,
                      size: 19,
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================
// Edit Task Sheet
// =========================================================
//
// هذا الجزء خاص بتعديل Task موجودة.
//
// =========================================================

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

class _EditTaskSheetState
    extends State<_EditTaskSheet> {
  late final TextEditingController
  _titleController;

  late final TextEditingController
  _descriptionController;

  late bool _isHighPriority;

  String? _selectedDate;

  String? _imagePath;

  final ImagePicker _imagePicker =
  ImagePicker();

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
    final now =
    DateTime.now();

    final picked =
    await showDatePicker(
      context: context,

      initialDate: now,

      firstDate: now,

      lastDate: DateTime(
        now.year + 10,
      ),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedDate =
      "${picked.year}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.day.toString().padLeft(2, '0')}";
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

    if (!mounted) return;

    setState(() {
      _imagePath =
          image.path;
    });
  }

  // =======================================================
  // Save Changes
  // =======================================================

  void _saveChanges() {
    final name =
    _titleController.text.trim();

    if (name.isEmpty) {
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
      taskName: name,

      taskDescription:
      _descriptionController
          .text
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
  Widget build(
      BuildContext context,
      ) {
    final theme =
    Theme.of(context);

    final bottomInset =
        MediaQuery.of(context)
            .viewInsets
            .bottom;

    return Padding(
      padding:
      EdgeInsets.only(
        bottom: bottomInset,
      ),

      child: Container(
        decoration:
        BoxDecoration(
          color: theme
              .scaffoldBackgroundColor,

          borderRadius:
          const BorderRadius
              .vertical(
            top: Radius.circular(
              22,
            ),
          ),
        ),

        padding:
        const EdgeInsets.all(
          16,
        ),

        child:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,

                  decoration:
                  BoxDecoration(
                    color:
                    theme.dividerColor,

                    borderRadius:
                    BorderRadius
                        .circular(
                      10,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                "Edit Task",
                style: theme
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                  fontWeight:
                  FontWeight.w600,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // =================================================
              // Task Name
              // =================================================

              Text(
                "Task Name",
                style: theme
                    .textTheme
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
                style: theme
                    .textTheme
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
              // Priority
              // =================================================

              SwitchListTile(
                contentPadding:
                EdgeInsets.zero,

                title:
                const Text(
                  "High Priority",
                ),

                value:
                _isHighPriority,

                onChanged:
                    (value) {
                  setState(() {
                    _isHighPriority =
                        value;
                  });
                },
              ),

              const Divider(),

              // =================================================
              // Date
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading:
                const Icon(
                  Icons
                      .calendar_today_outlined,
                ),

                title:
                const Text(
                  "Due Date",
                ),

                subtitle:
                _selectedDate ==
                    null
                    ? const Text(
                  "No date selected",
                )
                    : Text(
                  _selectedDate!,
                ),

                trailing:
                _selectedDate ==
                    null
                    ? const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 16,
                )
                    : IconButton(
                  icon:
                  const Icon(
                    Icons.close,
                  ),
                  onPressed:
                      () {
                    setState(
                          () {
                        _selectedDate =
                        null;
                      },
                    );
                  },
                ),

                onTap:
                _pickDate,
              ),

              const Divider(),

              // =================================================
              // Image
              // =================================================

              ListTile(
                contentPadding:
                EdgeInsets.zero,

                leading:
                const Icon(
                  Icons
                      .image_outlined,
                ),

                title:
                const Text(
                  "Task Image",
                ),

                subtitle:
                _imagePath ==
                    null
                    ? const Text(
                  "Choose an image",
                )
                    : const Text(
                  "Image selected",
                ),

                trailing:
                _imagePath ==
                    null
                    ? const Icon(
                  Icons
                      .arrow_forward_ios,
                  size: 16,
                )
                    : IconButton(
                  icon:
                  const Icon(
                    Icons
                        .delete_outline,
                  ),
                  onPressed:
                      () {
                    setState(
                          () {
                        _imagePath =
                        null;
                      },
                    );
                  },
                ),

                onTap:
                _pickImage,
              ),

              if (_imagePath != null &&
                  File(_imagePath!)
                      .existsSync())
                Padding(
                  padding:
                  const EdgeInsets
                      .only(
                    top: 8,
                  ),

                  child:
                  ClipRRect(
                    borderRadius:
                    BorderRadius
                        .circular(
                      12,
                    ),

                    child:
                    Image.file(
                      File(
                        _imagePath!,
                      ),

                      width:
                      double.infinity,

                      height: 150,

                      fit:
                      BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(
                height: 20,
              ),

              // =================================================
              // Save
              // =================================================

              SizedBox(
                width:
                double.infinity,

                height: 48,

                child:
                ElevatedButton(
                  onPressed:
                  _saveChanges,

                  child:
                  const Text(
                    "Save Changes",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}