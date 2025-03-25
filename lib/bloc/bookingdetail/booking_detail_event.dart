part of 'booking_detail_bloc.dart';

abstract class BookingDetailEvent {}

class FetchBookingDetailEvent extends BookingDetailEvent {}

class FetchBookingsSlotEvent extends BookingDetailEvent {}
