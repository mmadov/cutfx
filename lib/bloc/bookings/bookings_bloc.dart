import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/address/manage_my_addresses.dart';
import 'package:cutfx/screens/barber/choose_your_expert_bottom.dart';
import 'package:cutfx/screens/payment/make_payment_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'bookings_event.dart';
part 'bookings_state.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  BookingsBloc() : super(BookingsInitial()) {
    on<FetchBookingsArgumentsEvent>((event, emit) async {
      Map<String, dynamic> map = Get.arguments;
      if (salonData == null) {
        salonData = map[ConstRes.salonData];
        services = map[ConstRes.services];
      }
      if (day != lastDay || staffData?.id != staffId) {
        lastDay = day;
        selectedTime = null;

        staffId = staffData?.id?.toInt() ?? -1;
        emit(BookingsInitial());
        Slot? slot = await ApiService().fetchAvailableSlotsOfStaff(
          salonData?.id ?? -1,
          staffData?.id ?? -1,
          '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}',
          selectedDate?.weekday ?? 0,
        );

        // Booking booking =
        //     await ApiService().fetchAcceptedPendingBookingsOfSalonByDate(
        //   salonData?.id?.toInt() ?? -1,
        //   '$year-$month-$day',
        // );
        slots = AppRes.sortingSlots(slot.data, month, day, true);
        slots.addAll(AppRes.sortingSlots(slot.data, month, day, false));
      }

      emit(BookingArgumentsFetchedState());
    });
    add(FetchBookingsArgumentsEvent());
  }

  SalonData? salonData;
  StaffData? staffData;
  List<Services> services = [];
  List<SlotData> slots = [];
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  int lastDay = -1;
  int staffId = -1;
  int weekDay = DateTime.now().weekday;
  RxInt serviceLocationType = 0.obs;
  Rx<AddressData> addressData = AddressData(id: -1).obs;

  List<DateTime> days = List<DateTime>.generate(
      AppRes.totalDays,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(hours: 24 * i)));

  void clickOnMakePayment() {
    if (selectedDate == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectDate, false);
      return;
    }
    if (staffData == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectBarber, false);
      return;
    }
    if (selectedTime == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectTime, false);
      return;
    }
    if (serviceLocationType.value == 1) {
      if (addressData.value.id == -1) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseSelectAddress, false);
        return;
      }
    }
    // AppRes.showCustomLoader();
    Map<String, dynamic> map = {
      ConstRes.salonData: salonData,
      ConstRes.services: services,
      ConstRes.date: selectedDate,
      ConstRes.time: selectedTime,
      ConstRes.serviceLocation: serviceLocationType.value,
      ConstRes.address: addressData.value,
      ConstRes.staffData: staffData
    };
    Get.to(
      () => const MakePaymentScreen(),
      arguments: map,
    );
  }

  void removeService(int id) {
    if (services.length > 1) {
      for (Services? service in services) {
        if (service != null && service.id == id) {
          services.remove(service);
          break;
        }
      }
    }
    add(FetchBookingsArgumentsEvent());
  }

  int totalRates() {
    int totalPrice = 0;
    for (Services? service in services) {
      if (service != null) {
        totalPrice = totalPrice +
            ((service.price?.toInt() ?? 0) -
                AppRes.calculateDiscountByPercentage(
                        service.price?.toInt() ?? 0,
                        service.discount?.toInt() ?? 0)
                    .toInt());
      }
    }
    return totalPrice;
  }

  void onClickCalenderDay(DateTime day, BookingsBloc bookingsBloc) {
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
    bookingsBloc.add(FetchBookingsArgumentsEvent());
  }

  void onClickSelectAddress() {
    Get.to(() => const ManageMyAddressesScreen(), arguments: true)?.then(
      (value) {
        addressData.value = value;
      },
    );
  }

  void selectStaff(BookingsBloc bookingsBloc) {
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
          bookingsBloc.add(FetchBookingsArgumentsEvent());
        }
      },
    );
  }
}
