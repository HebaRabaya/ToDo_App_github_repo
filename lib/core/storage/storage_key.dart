// =========================================================
// Storage Key
// =========================================================
//
// هذا الملف فيه أسماء المفاتيح اللي بنستخدمها
// لما نخزن أو نقرأ البيانات من SharedPreferences.
//
// بدل ما نكتب "username" و "tasks" بكل مكان،
// بنحطهم هون ونستخدم StorageKey.username
// و StorageKey.tasks.
//
// هيك إذا بدنا نغير اسم المفتاح مستقبلاً،
// بنغيره بمكان واحد فقط.
//
// =========================================================

class StorageKey {
  static const String username = "username";

  static const String userImage = "userimage";

  static const String motivationQuote =
      "motivation_quote";

  static const String tasks = "tasks";

  static const String theme = "theme";
}