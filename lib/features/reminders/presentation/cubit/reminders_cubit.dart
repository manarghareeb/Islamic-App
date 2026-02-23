import 'package:flutter_bloc/flutter_bloc.dart';
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
      (success) => loadReminders(),
    );
  }

  Future<void> toggleReminderStatus(int index, ReminderEntity reminder) async {
    final updatedReminder = reminder.copyWith(isActive: !reminder.isActive);
    final result = await updateReminderUseCase(updatedReminder, index);
    result.fold(
      (failure) => emit(RemindersError(failure.message)),
      (success) => loadReminders(), 
    );
  }
}
