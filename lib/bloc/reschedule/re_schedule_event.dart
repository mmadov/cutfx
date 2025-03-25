part of 're_schedule_bloc.dart';

abstract class ReScheduleEvent {}

class UpdateDataEvent extends ReScheduleEvent {}

class FetchBookingsSlotEvent extends ReScheduleEvent {}
