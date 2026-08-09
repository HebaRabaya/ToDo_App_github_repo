// =========================================================
// Task Model
// =========================================================

// هذا الـ Model بحدد شكل الـ Task داخل التطبيق.
//
// كل Task عندها:
// - ID خاص فيها
// - اسم
// - وصف
// - High Priority
// - Completed
// - تاريخ
// - صورة اختيارية
class TaskModel {
  // =========================================================
  // Properties
  // =========================================================

  // ID خاص بالتاسك
  final String taskId;

  // اسم التاسك
  final String taskName;

  // وصف التاسك
  final String taskDescription;

  // هل التاسك High Priority؟
  final bool isHighPriority;

  // هل التاسك مكتملة؟
  final bool isCompleted;

  // تاريخ التسليم
  final String? dueDate;

  // مسار الصورة الموجودة على الجهاز
  final String? imagePath;

  // =========================================================
  // Constructor
  // =========================================================

  const TaskModel({
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    required this.isCompleted,
    this.dueDate,
    this.imagePath,
  });

  // =========================================================
  // To Map
  // =========================================================

  // بنحول الـ Task إلى Map
  // عشان نقدر نخزنها كـ JSON.
  Map<String, dynamic> toMap() {
    return {
      "taskId": taskId,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isCompleted": isCompleted,
      "dueDate": dueDate,
      "imagePath": imagePath,
    };
  }

  // =========================================================
  // To JSON
  // =========================================================

  Map<String, dynamic> toJson() {
    return toMap();
  }

  // =========================================================
  // From Map
  // =========================================================

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    final taskName = map["taskName"] ?? "";
    final taskDescription = map["taskDescription"] ?? "";

    // إذا التاسك قديمة وما كان إلها ID
    // بنعمل ID ثابت من الاسم والوصف.
    final taskId =
        map["taskId"] ??
            "${taskName}_$taskDescription";

    return TaskModel(
      taskId: taskId.toString(),
      taskName: taskName.toString(),
      taskDescription: taskDescription.toString(),
      isHighPriority:
      map["isHighPriority"] ?? false,
      isCompleted:
      map["isCompleted"] ?? false,
      dueDate: map["dueDate"]?.toString(),
      imagePath: map["imagePath"]?.toString(),
    );
  }

  // =========================================================
  // From JSON
  // =========================================================

  factory TaskModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return TaskModel.fromMap(json);
  }

  // =========================================================
  // Copy With
  // =========================================================

  // بنستخدمها لما بدنا نغير قيمة معينة
  // ونخلي باقي القيم زي ما هي.
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
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      taskDescription:
      taskDescription ?? this.taskDescription,
      isHighPriority:
      isHighPriority ?? this.isHighPriority,
      isCompleted:
      isCompleted ?? this.isCompleted,
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