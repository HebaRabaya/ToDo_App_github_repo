// =========================================================
// Task Model
// =========================================================
//
// هذا الملف بيمثل شكل الـ Task داخل التطبيق.
//
// بدل ما نخزن معلومات التاسك بشكل عشوائي،
// بنجمع كل معلوماتها داخل Object واحد.
//
// كل Task عندها:
// - ID
// - Name
// - Description
// - High Priority
// - Completed
// - Due Date
// - Image
//
// وكمان الملف مسؤول عن تحويل الـ Task:
// Object → Map
// Map → Object
//
// عشان نقدر نحفظها ونرجع نقرأها من التخزين.
//
// =========================================================

class TaskModel {
  final String taskId;

  final String taskName;

  final String taskDescription;

  final bool isHighPriority;

  final bool isCompleted;

  final String? dueDate;

  final String? imagePath;

  const TaskModel({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    required this.isCompleted,
    this.dueDate,
    this.imagePath,
  });

  // =======================================================
  // To Map
  // =======================================================

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isCompleted': isCompleted,
      'dueDate': dueDate,
      'imagePath': imagePath,
    };
  }

  // =======================================================
  // To JSON
  // =======================================================

  Map<String, dynamic> toJson() {
    return toMap();
  }

  // =======================================================
  // From Map
  // =======================================================

  factory TaskModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return TaskModel(
      taskId:
      map['taskId']?.toString() ?? '',

      taskName:
      map['taskName']?.toString() ?? '',

      taskDescription:
      map['taskDescription']?.toString() ?? '',

      isHighPriority:
      map['isHighPriority'] == true,

      isCompleted:
      map['isCompleted'] == true,

      dueDate:
      map['dueDate']?.toString(),

      imagePath:
      map['imagePath']?.toString(),
    );
  }

  // =======================================================
  // From JSON
  // =======================================================

  factory TaskModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TaskModel.fromMap(json);
  }

  // =======================================================
  // Copy With
  // =======================================================

  TaskModel copyWith({
    String? taskId,
    String? taskName,
    String? taskDescription,
    bool? isHighPriority,
    bool? isCompleted,
    String? dueDate,
    String? imagePath,
    bool clearDueDate = false,
    bool clearImagePath = false,
  }) {
    return TaskModel(
      taskId:
      taskId ?? this.taskId,

      taskName:
      taskName ?? this.taskName,

      taskDescription:
      taskDescription ??
          this.taskDescription,

      isHighPriority:
      isHighPriority ??
          this.isHighPriority,

      isCompleted:
      isCompleted ??
          this.isCompleted,

      dueDate:
      clearDueDate
          ? null
          : dueDate ?? this.dueDate,

      imagePath:
      clearImagePath
          ? null
          : imagePath ?? this.imagePath,
    );
  }
}