import 'dart:convert';

import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/model/coupon/coupon.dart';
import 'package:cutfx/model/order_summary.dart';
import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/payment/booked_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'confirm_booking_event.dart';
part 'confirm_booking_state.dart';

class ConfirmBookingBloc
    extends Bloc<ConfirmBookingEvent, ConfirmBookingState> {
  ConfirmBookingBloc() : super(ConfirmBookingInitial()) {
    on<FetchArgumentsEvent>((event, emit) async {
      if (salonData == null) {
        Map<String, dynamic> map = Get.arguments ?? [];
        salonData = map[ConstRes.salonData];
        services = map[ConstRes.services];
        selectedDate = map[ConstRes.date];
        selectedTime = map[ConstRes.time];
        staffData = map[ConstRes.staffData];
        addressData = map[ConstRes.address];
        serviceLocationType = map[ConstRes.serviceLocation];
      }
      SharePref sharePref = await SharePref().init();
      setting = sharePref.getSettings();
      salonUser = sharePref.getSalonUser();
      emit(ArgumentDataFetchedEvent());
    });
    add(FetchArgumentsEvent());
  }

  SalonData? salonData;
  StaffData? staffData;
  AddressData? addressData;
  int serviceLocationType = 0;
  List<Services> services = [];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  CouponData? coupon;
  Setting? setting;
  SalonUser? salonUser;

  String? getTime() {
    int hour = selectedTime?.hour ?? 0;
    int min = selectedTime?.minute ?? 0;
    String selectedTime2 =
        '${hour < 10 ? '0$hour' : '$hour'}${min < 10 ? '0$min' : '$min'}';
    return selectedTime2;
  }

  int getTotalMinOfServices() {
    int min = 0;
    for (Services? service in services) {
      if (service != null) {
        min += service.serviceTime?.toInt() ?? 0;
      }
    }
    return min;
  }

  int getSubTotalAmount() {
    int totalAmount = 0;
    for (Services? service in services) {
      if (service != null) {
        totalAmount += (service.price?.toInt() ?? 0) -
            AppRes.calculateDiscountByPercentage(
                    service.price?.toInt() ?? 0, service.discount?.toInt() ?? 0)
                .toInt();
      }
    }
    totalAmount = totalAmount - discount;
    return totalAmount;
  }

  int discount = 0;

  int calculateTax(Taxes? tax) {
    if (tax?.type == 1) {
      return tax?.value?.toInt() ?? 0;
    } else {
      return ((getSubTotalAmount() * (tax?.value?.toInt() ?? 1)) / 100).round();
    }
  }

  int getTotalPayableAmount() {
    int totalAmount = getSubTotalAmount();
    List<Taxes>? taxes = setting?.data?.taxes;
    int totalTax = 0;
    for (int i = 0;
        i < (taxes != null && taxes.isNotEmpty ? taxes.length : 0);
        i++) {
      Taxes? tax = taxes?[i];
      totalTax += calculateTax(tax);
    }
    totalAmount += totalTax;
    return totalAmount;
  }

  num getDiscount() {
    if (coupon != null) {
      num discount = 0;
      int subTotal = getSubTotalAmount();
      discount = (subTotal * coupon!.percentage!.toDouble()) / 100;
      if (discount > coupon!.maxDiscountAmount!.toInt()) {
        discount = coupon!.maxDiscountAmount!.toInt();
      }
      this.discount = discount.toInt();
      return discount;
    }
    return 0;
  }

  removeCoupon() {
    coupon = null;
    discount = 0;
    add(FetchArgumentsEvent());
  }

  void selectCoupon(CouponData couponData) {
    coupon = couponData;
    int subTotal = getSubTotalAmount();
    if (coupon!.minOrderAmount!.toInt() > subTotal) {
      coupon = null;
      AppRes.showSnackBar('Your booking amount is not enough...!', false);
    }
    add(FetchArgumentsEvent());
  }

  int paymentType = 0;

  void payNow() {
    List<Taxes> taxes = setting?.data?.taxes ?? [];
    List<Taxes> finalTaxes = [];
    int totalTaxAmount = 0;
    int serviceAmount = 0;
    for (int i = 0; i < taxes.length; i++) {
      Taxes tax = taxes[i];
      int taxAmount = calculateTax(tax);
      totalTaxAmount += taxAmount;
      Taxes finalTax = tax.copyWith(taxAmount: taxAmount);
      finalTaxes.add(finalTax);
    }
    for (int i = 0; i < services.length; i++) {
      serviceAmount += (services[i].price?.toInt() ?? 0) -
          AppRes.calculateDiscountByPercentage(services[i].price?.toInt() ?? 0,
                  services[i].discount?.toInt() ?? 0)
              .toInt();
    }
    OrderSummary orderSummary = OrderSummary(
      coupon: coupon,
      couponApply: coupon != null ? 1 : 0,
      discountAmount: getDiscount(),
      payableAmount: getTotalPayableAmount(),
      services: services,
      subtotal: getSubTotalAmount(),
      taxes: finalTaxes,
      totalTaxAmount: totalTaxAmount,
      serviceAmount: serviceAmount,
    );
    AppRes.showCustomLoader();
    ApiService()
        .placeBooking(
      salonId_: salonData?.id?.toInt() ?? -1,
      date: AppRes.formatDate(selectedDate ?? DateTime.now(),
          pattern: 'yyyy-MM-dd'),
      time:
          '${0.convert2Digits(selectedTime?.hour)}${0.convert2Digits(selectedTime?.minute)}',
      duration: getTotalMinOfServices(),
      services: jsonEncode(orderSummary),
      payableAmount: orderSummary.payableAmount?.toInt() ?? 0,
      isCouponApplied: orderSummary.couponApply?.toInt() ?? 0,
      couponTitle: coupon?.heading ?? '',
      couponId: coupon?.id?.toInt() ?? -1,
      discountAmount: orderSummary.discountAmount?.toInt() ?? 0,
      serviceAmount: serviceAmount,
      subtotal: orderSummary.subtotal?.toInt() ?? 0,
      totalTaxAmount: orderSummary.totalTaxAmount?.toInt() ?? 0,
      paymentType: paymentType,
      staffId: staffData?.id?.toInt(),
      serviceLocation: serviceLocationType,
      addressId: addressData?.id?.toInt(),
    )
        .then((value) {
      AppRes.hideCustomLoader();
      if (value.status!) {
        Get.offAll(const AppointmentBookedScreen(),
            arguments: value.data?.bookingId);
      } else {
        AppRes.showSnackBar(value.message ?? '', false);
      }
    });
  }
}

extension Convert2Digits on int {
  String convert2Digits(int? value) {
    return value.toString().length < 2 ? '0$value' : value.toString();
  }
}
