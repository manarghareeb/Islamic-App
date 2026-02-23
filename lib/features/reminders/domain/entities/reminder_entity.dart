class ReminderEntity {
  final String title;
  final String time;
  final List<int> gradientColor;
  final int iconCode;
  final bool isActive;

  ReminderEntity({
    required this.title,
    required this.time,
    required this.gradientColor,
    required this.iconCode,
    this.isActive = true,
  });

  ReminderEntity copyWith({
    String? title,
    String? time,
    List<int>? gradientColor,
    int? iconCode,
    bool? isActive,
  }) {
    return ReminderEntity(
      title: title ?? this.title,
      time: time ?? this.time,
      gradientColor: gradientColor ?? this.gradientColor,
      iconCode: iconCode ?? this.iconCode,
      isActive: isActive ?? this.isActive,
    );
  }
}
