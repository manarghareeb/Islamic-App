import 'package:islamic_app/features/reminders/domain/entities/reminder_entity.dart';

abstract class RemindersState  {
  const RemindersState();
}

class RemindersInitial extends RemindersState {}

class RemindersLoading extends RemindersState {}

class RemindersLoaded extends RemindersState {
  final List<ReminderEntity> reminders;
  const RemindersLoaded(this.reminders);
}

class RemindersError extends RemindersState {
  final String message;
  const RemindersError(this.message);
}