import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

// =========================================================
// Add Task Screen
// =========================================================

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

// =========================================================
// Logic
// =========================================================

class _AddTaskScreenState
    extends State<AddTaskScreen> {
  // Controllers
  final TextEditingController
  _titleController =
  TextEditingController();

  final TextEditingController
  _descriptionController =
  TextEditingController();

  // High Priority
  bool _isHighPriority = true;

  // Date
  String? _selectedDate;

  // Image
  String? _imagePath;

  final ImagePicker _imagePicker =
  ImagePicker();

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

    final pickedDate =
    await showDatePicker(
      context: context,

      initialDate: now,

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
  // Add Task
  // =======================================================

  Future<void> _addTask() async {
    final taskName =
    _titleController.text.trim();

    // التأكد من وجود اسم
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

    // إنشاء ID جديد
    final taskId =
    DateTime.now()
        .microsecondsSinceEpoch
        .toString();

    // إنشاء التاسك
    final task = TaskModel(
      taskId: taskId,
      taskName: taskName,
      taskDescription:
      _descriptionController.text
          .trim(),
      isHighPriority:
      _isHighPriority,
      isCompleted: false,
      dueDate: _selectedDate,
      imagePath: _imagePath,
    );

    // حفظ التاسك
    await PreferencesManager.instance
        .addTask(task);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Task added successfully",
        ),
      ),
    );

    // الرجوع
    Navigator.pop(context);
  }

  // =======================================================
  // Build
  // =======================================================

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "New Task",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
              SingleChildScrollView(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 13,
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    const SizedBox(
                      height: 8,
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

                      style: theme
                          .textTheme
                          .bodyMedium,

                      decoration:
                      const InputDecoration(
                        hintText:
                        "Finish UI design for login screen",
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

                      maxLines: 5,

                      style: theme
                          .textTheme
                          .bodyMedium,

                      decoration:
                      const InputDecoration(
                        hintText:
                        "Finish onboarding UI and hand off to devs by Thursday.",
                      ),
                    ),

                    const SizedBox(
                      height: 16,
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
                    // Date
                    // =================================================

                    ListTile(
                      contentPadding:
                      EdgeInsets.zero,

                      leading: const Icon(
                        Icons
                            .calendar_today_outlined,
                      ),

                      title: const Text(
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
                          Icons
                              .close,
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

                      leading: const Icon(
                        Icons
                            .image_outlined,
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
                        icon:
                        const Icon(
                          Icons
                              .delete_outline,
                        ),
                        onPressed:
                        _removeImage,
                      ),

                      onTap:
                      _pickImage,
                    ),

                    if (_imagePath !=
                        null &&
                        File(_imagePath!)
                            .existsSync())
                      Padding(
                        padding:
                        const EdgeInsets
                            .only(
                          top: 8,
                        ),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(
                            12,
                          ),
                          child: Image.file(
                            File(
                              _imagePath!,
                            ),
                            width:
                            double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // Add Button
            // =================================================

            Container(
              width:
              double.infinity,

              padding:
              const EdgeInsets
                  .fromLTRB(
                13,
                8,
                13,
                24,
              ),

              color: theme
                  .scaffoldBackgroundColor,

              child: SizedBox(
                height: 45,

                child:
                ElevatedButton(
                  onPressed:
                  _addTask,

                  child: const Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                    children: [
                      Icon(
                        Icons.add,
                        size: 17,
                      ),

                      SizedBox(
                        width: 7,
                      ),

                      Text(
                        "Add Task",
                        style:
                        TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}