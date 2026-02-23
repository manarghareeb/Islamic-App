import 'package:hive/hive.dart';
import '../models/reminder_model.dart';

abstract class RemindersLocalDataSource {
  Future<void> addReminder(ReminderModel reminder);
  Future<List<ReminderModel>> getReminders();
  Future<void> updateReminder(ReminderModel reminder, int index);
}

class RemindersLocalDataSourceImpl implements RemindersLocalDataSource {
  final Box<ReminderModel> box;
  RemindersLocalDataSourceImpl(this.box);

  @override
  Future<void> addReminder(ReminderModel reminder) async {
    await box.add(reminder);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    return box.values.cast<ReminderModel>().toList();
  }

  @override
  Future<void> updateReminder(ReminderModel reminder, int index) async {
  await box.putAt(index, reminder);
}
}