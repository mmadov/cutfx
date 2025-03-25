import 'package:cutfx/model/bookings/booking_details.dart';
import 'package:cutfx/model/rest/rest_response.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/custom/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'booking_detail_event.dart';
part 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  BookingDetailBloc() : super(BookingDetailInitial()) {
    on<FetchBookingDetailEvent>((event, emit) async {
      if (bookingId.isEmpty) {
        bookingId = Get.arguments;
      }
      bookingDetails = await ApiService().fetchBookingDetails(bookingId);
      emit(BookingDetailDataFoundState());
    });
    on<FetchBookingsSlotEvent>((event, emit) async {
      selectedTime = TimeOfDay(
          hour: int.parse(bookingDetails?.data?.time?.substring(0, 2) ?? '0'),
          minute:
              int.parse(bookingDetails?.data?.time?.substring(2, 4) ?? '0'));
      selectedDate = AppRes.parseDate(
        bookingDetails?.data?.date ?? '',
        pattern: 'yyyy-MM-dd',
        isUtc: false,
      );
      salonData ??= bookingDetails?.data?.salonData;
      year = selectedDate?.year ?? DateTime.now().year;
      month = selectedDate?.month ?? DateTime.now().month;
      day = selectedDate?.day ?? DateTime.now().day;
      weekDay = selectedDate?.weekday ?? DateTime.now().weekday;

      if (day != lastDay) {
        lastDay = day;
        selectedTime = null;
        emit(BookingDetailSlotsInitial());
        slots = salonData?.slots?.where((element) {
              return element.weekday == weekDay;
            }).toList() ??
            [];
      }
      emit(BookingDetailSlotsDataFoundState());
    });
    add(FetchBookingDetailEvent());
  }

  BookingDetails? bookingDetails;
  String bookingId = '';
  SalonData? salonData;
  List<Services> services = [];
  List<SlotData> slots = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int lastDay = -1;
  int weekDay = DateTime.now().weekday;
  List<DateTime> days = List<DateTime>.generate(
      AppRes.totalDays,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(hours: 24 * i)));

  void cancelBooking() {
    Get.bottomSheet(
      ConfirmationBottomSheet(
        title: AppLocalizations.of(Get.context!)!.cancelBooking,
        description: AppLocalizations.of(Get.context!)!
            .doYouReallyWantToCancelThisBookingnthisActionCant,
        buttonText: AppLocalizations.of(Get.context!)!.cancel,
        onButtonClick: () async {
          AppRes.showCustomLoader();
          RestResponse response = await ApiService()
              .cancelBooking(bookingDetails?.data?.bookingId ?? '');
          AppRes.hideCustomLoaderWithBack();
          AppRes.showSnackBar(response.message ?? '', response.status ?? false);
          add(FetchBookingDetailEvent());
        },
      ),
    );
  }

  void onClickCalenderDay(DateTime day, BookingDetailBloc bookingsBloc) {
    int differenceDay = day.difference(DateTime.now()).inDays;

    if (differenceDay < 0 || differenceDay > 90) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!
              .youCanMakeBookingsOnlyForTodayOrForThe,
          false);
      return;
    }
    month = day.month;
    this.day = day.day;
    weekDay = day.weekday;
    year = day.year;
    selectedDate = day;
    bookingsBloc.add(FetchBookingsSlotEvent());
  }
}
