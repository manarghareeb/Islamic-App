import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';

import '../entities/reminder_entity.dart';

abstract class RemindersRepository {
  Future<Either<Failure, void>> addReminder(ReminderEntity reminder);
  Future<Either<Failure, List<ReminderEntity>>> getReminders();
  Future<Either<Failure, void>> updateReminder(ReminderEntity reminder, int index);
}