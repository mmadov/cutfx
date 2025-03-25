import 'package:cutfx/bloc/confirmbooking/confirm_booking_bloc.dart';
import 'package:cutfx/model/bookings/booking_details.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/barber/choose_your_expert_bottom.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 're_schedule_event.dart';
part 're_schedule_state.dart';

class ReScheduleBloc extends Bloc<ReScheduleEvent, ReScheduleState> {
  ReScheduleBloc() : super(ReScheduleInitial()) {
    on<UpdateDataEvent>((event, emit) async {
      if (salonData == null) {
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
      }
      if (day != lastDay || staffData?.id != staffId) {
        lastDay = day;
        selectedTime = null;

        staffId = staffData?.id?.toInt() ?? -1;
        emit(ReScheduleInitial());
        Slot? slot = await ApiService().fetchAvailableSlotsOfStaff(
          salonData?.id ?? -1,
          staffData?.id ?? -1,
          '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
          selectedDate?.weekday ?? 0,
        );

        slots = AppRes.sortingSlots(slot.data, month, day, true);
        slots.addAll(AppRes.sortingSlots(slot.data, month, day, false));
      }
      emit(UpdateReScheduleDataState());
    });
  }

  BookingDetails? bookingDetails;
  StaffData? staffData;
  SalonData? salonData;
  int staffId = -1;
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

  void onSubmitClick() async {
    AppRes.showCustomLoader();
    await ApiService().rescheduleBooking(
        bookingDetails?.data?.bookingId ?? '',
        AppRes.formatDate(selectedDate ?? DateTime.now(),
            pattern: 'yyyy-MM-dd'),
        '${0.convert2Digits(selectedTime?.hour)}${0.convert2Digits(selectedTime?.minute)}',
        staffId);
    AppRes.hideCustomLoaderWithBack();
  }

  void onClickCalenderDay(DateTime day, ReScheduleBloc bookingsBloc) {
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
    bookingsBloc.add(UpdateDataEvent());
  }

  void selectStaff(ReScheduleBloc bookingsBloc) {
    Get.bottomSheet(
      ChooseYourExpertBottom(
        salonData: salonData,
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
      barrierColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ).then(
      (value) {
        if (value != null) {
          staffData = value;
          bookingsBloc.add(UpdateDataEvent());
        }
      },
    );
  }
}
