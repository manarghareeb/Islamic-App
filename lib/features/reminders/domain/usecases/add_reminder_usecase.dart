import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';

import '../entities/reminder_entity.dart';
import '../repositories/reminders_repository.dart';

class AddReminderUseCase {
  final RemindersRepository repository;

  AddReminderUseCase({required this.repository});

  Future<Either<Failure, void>> call(ReminderEntity reminder) async {
    return await repository.addReminder(reminder);
  }
}