import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/reminders/domain/entities/reminder_entity.dart';
import 'package:islamic_app/features/reminders/domain/repositories/reminders_repository.dart';

class UpdateReminderUseCase {
  final RemindersRepository repository;
  UpdateReminderUseCase({required this.repository});

  Future<Either<Failure, void>> call(ReminderEntity reminder, int index) async {
    return await repository.updateReminder(reminder, index);
  }
}