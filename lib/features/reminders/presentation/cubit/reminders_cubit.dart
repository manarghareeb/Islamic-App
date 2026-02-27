import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/core/services/local_notifications_service.dart';
import 'package:islamic_app/features/reminders/domain/entities/reminder_entity.dart';
import 'package:islamic_app/features/reminders/domain/repositories/reminders_repository.dart';
import 'package:islamic_app/features/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:islamic_app/features/reminders/domain/usecases/update_reminder_usecase.dart';
import 'package:islamic_app/features/reminders/presentation/cubit/reminders_stare.dart';

class RemindersCubit extends Cubit<RemindersState> {
  final RemindersRepository repository;
  final AddReminderUseCase addReminderUseCase;
  final UpdateReminderUseCase updateReminderUseCase;

  RemindersCubit({required this.repository, required this.addReminderUseCase, required this.updateReminderUseCase})
    : super(RemindersInitial());

  Future<void> loadReminders() async {
    emit(RemindersLoading());
    final result = await repository.getReminders();
    result.fold(
      (failure) => emit(RemindersError(failure.message)),
      (reminders) => emit(RemindersLoaded(reminders)),
    );
  }

  Future<void> addReminder(ReminderEntity reminder) async {
    final result = await addReminderUseCase(reminder);
    result.fold(
      (failure) => emit(RemindersError(failure.message)),
      (success) async {
        await _handleNotification(reminder);
        loadReminders();
      },
    );
  }

  Future<void> toggleReminderStatus(int index, ReminderEntity reminder) async {
    final updatedReminder = reminder.copyWith(isActive: !reminder.isActive);
    final result = await updateReminderUseCase(updatedReminder, index);
    result.fold(
      (failure) => emit(RemindersError(failure.message)),
     (success) async {
        await _handleNotification(updatedReminder);
        loadReminders();
      },
    );
  }

  Future<void> _handleNotification(ReminderEntity reminder) async {
    final int notificationId = reminder.title.hashCode;

    if (reminder.isActive) {
      try {
        final parts = reminder.time.split(':');
        final int hour = int.parse(parts[0]);
        final int minute = int.parse(parts[1]);

        await LocalNotificationsService.scheduleDailyReminder(
          id: notificationId,
          title: 'التذكير اليومي',
          body: reminder.title,
          hour: hour,
          minute: minute,
        );
      } catch (e) {
        print("Error parsing time for notification: $e");
      }
    } else {
      await LocalNotificationsService.cancelNotification(notificationId);
    }
  }
}
