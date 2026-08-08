// =========================================================
// Task Model
// =========================================================

// هذا الـ Model بحدد شكل الـ Task
class TaskModel {
  // اسم التاسك
  final String taskName;

  // وصف التاسك
  final String taskDescription;

  // هل التاسك High Priority؟
  final bool isHighPriority;

  // هل التاسك مكتملة؟
  final bool isCompleted;

  // =========================================================
  // Constructor
  // =========================================================

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    required this.isCompleted,
  });

  // =========================================================
  // To Map
  // =========================================================

  // بنحول الـ Task إلى Map
  Map<String, dynamic> toMap() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isCompleted": isCompleted,
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
    return TaskModel(
      taskName: map["taskName"] ?? "",
      taskDescription: map["taskDescription"] ?? "",
      isHighPriority: map["isHighPriority"] ?? false,
      isCompleted: map["isCompleted"] ?? false,
    );
  }

  // =========================================================
  // From JSON
  // =========================================================

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel.fromMap(json);
  }

  // =========================================================
  // Copy With
  // =========================================================

  // بنستخدمها لما بدنا نغير قيمة معينة
  // ونخلي باقي القيم زي ما هي
  TaskModel copyWith({
    String? taskName,
    String? taskDescription,
    bool? isHighPriority,
    bool? isCompleted,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      isHighPriority: isHighPriority ?? this.isHighPriority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}