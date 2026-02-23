import 'package:dartz/dartz.dart';
import 'package:islamic_app/core/error/failures.dart';
import 'package:islamic_app/features/reminders/data/data_sources/reminders_local_datasource.dart';

import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/reminders_repository.dart';
import '../models/reminder_model.dart';

class RemindersRepositoryImpl implements RemindersRepository {
  final RemindersLocalDataSource localDataSource;

  RemindersRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addReminder(ReminderEntity reminder) async {
    try {
      final reminderModel = ReminderModel.fromEntity(reminder);
      await localDataSource.addReminder(reminderModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("فشل في حفظ التذكير: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<ReminderEntity>>> getReminders() async {
    try {
      final reminders = await localDataSource.getReminders();
      return Right(reminders);
    } catch (e) {
      return Left(ServerFailure("حدث خطأ أثناء استعادة التذكيرات"));
    }
  }

  @override
  Future<Either<Failure, void>> updateReminder(
    ReminderEntity reminder,
    int index,
  ) async {
    try {
      final reminderModel = ReminderModel.fromEntity(reminder);
      await localDataSource.updateReminder(reminderModel, index);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure("فشل في تحديث التذكير: ${e.toString()}"));
    }
  }
}
