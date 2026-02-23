import 'package:hive/hive.dart';
import '../../domain/entities/reminder_entity.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends ReminderEntity{
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final List<int> gradientColor;

  @HiveField(3)
  final int iconCode;

  @HiveField(4)
  final bool isActive;

  ReminderModel({
    required this.title,
    required this.time,
    required this.gradientColor,
    required this.iconCode,
    this.isActive = true,
  }) : super(
          title: title,
          time: time,
          gradientColor: gradientColor,
          iconCode: iconCode,
          isActive: isActive,
        );

  factory ReminderModel.fromEntity(ReminderEntity entity) => ReminderModel(
        title: entity.title,
        time: entity.time,
        gradientColor: entity.gradientColor,
        iconCode: entity.iconCode,
        isActive: entity.isActive,
      );

  ReminderModel copyWith({
    String? title,
    String? time,
    List<int>? gradientColor,
    int? iconCode,
    bool? isActive,
  }) {
    return ReminderModel(
      title: title ?? this.title,
      time: time ?? this.time,
      gradientColor: gradientColor ?? this.gradientColor,
      iconCode: iconCode ?? this.iconCode,
      isActive: isActive ?? this.isActive,
    );
  }

  ReminderEntity toEntity() => ReminderEntity(
        title: title,
        time: time,
        gradientColor: gradientColor,
        iconCode: iconCode,
        isActive: isActive,
      );
}