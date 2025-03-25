import 'package:cutfx/model/bookings/booking.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_history_event.dart';
part 'booking_history_state.dart';

class BookingHistoryBloc
    extends Bloc<BookingHistoryEvent, BookingHistoryState> {
  BookingHistoryBloc() : super(BookingHistoryInitial()) {
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchUpcomingHistoryEvent());
      }
    });
    on<FetchUpcomingHistoryEvent>((event, emit) async {
      Booking booking =
          await ApiService().fetchUserUpcomingBookings(bookings.length);
      bookings.addAll(booking.data ?? []);
      // bookings.sort(
      //   (a, b) {
      //     return a.status!.compareTo(b.status!);
      //   },
      // );
      emit(BookingHistoryDataFoundState());
    });
    add(FetchUpcomingHistoryEvent());
  }

  ScrollController scrollController = ScrollController();
  bool isFetching = false;
  List<BookingData> bookings = [];

  void updateData() {
    bookings = [];
    add(FetchUpcomingHistoryEvent());
  }
}
