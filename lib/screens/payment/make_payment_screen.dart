import 'dart:io';

import 'package:cutfx/bloc/confirmbooking/confirm_booking_bloc.dart';
import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/payment/coupon_bottom_sheet.dart';
import 'package:cutfx/screens/payment/recharge_wallet_sheet.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmBookingBloc(),
      child: Scaffold(
        body: BlocBuilder<ConfirmBookingBloc, ConfirmBookingState>(
          builder: (context, state) {
            ConfirmBookingBloc confirmBookingBloc =
                context.read<ConfirmBookingBloc>();
            return Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.confirmBooking,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      color: ColorRes.themeColor10,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Text(
                      '${AppRes.currency}${confirmBookingBloc.salonUser?.data?.wallet?.toString() ?? ''}',
                      style: kSemiBoldThemeTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: ColorRes.smokeWhite2,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.date,
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      AppRes.formatDate(
                                          confirmBookingBloc.selectedDate ??
                                              DateTime.now(),
                                          pattern: 'dd MMM yyyy'),
                                      style: kRegularThemeTextStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.time,
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      AppRes.convert24HoursInto12Hours(
                                          confirmBookingBloc.getTime()),
                                      style: kRegularThemeTextStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.duration,
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      AppRes.convertTimeForService(
                                          confirmBookingBloc
                                              .getTotalMinOfServices()),
                                      style: kRegularThemeTextStyle.copyWith(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 20,
                              bottom: 10,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.serviceLocation,
                              style: kLightWhiteTextStyle.copyWith(
                                color: ColorRes.empress,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          BookingAddressWidget(
                            addressData: confirmBookingBloc.addressData,
                            serviceLocationType:
                                confirmBookingBloc.serviceLocationType,
                          ),
                          Visibility(
                            visible: confirmBookingBloc.staffData != null,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 20,
                                bottom: 10,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.barber,
                                style: kLightWhiteTextStyle.copyWith(
                                  color: ColorRes.empress,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: confirmBookingBloc.staffData != null,
                            child: Container(
                              color: ColorRes.smokeWhite,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      color: ColorRes.smokeWhite2,
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            '${ConstRes.itemBaseUrl}${confirmBookingBloc.staffData?.photo}',
                                        fit: BoxFit.cover,
                                        placeholder: '1',
                                        placeholderErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Image(
                                              image:
                                                  AssetImage(AssetRes.icUser),
                                            ),
                                          );
                                        },
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Image(
                                              image:
                                                  AssetImage(AssetRes.icUser),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            confirmBookingBloc
                                                    .staffData?.name ??
                                                '',
                                            style:
                                                kRegularThemeTextStyle.copyWith(
                                              color: ColorRes.nero,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            AppRes
                                                .getGenderTypeInStringFromNumber(
                                                    context,
                                                    confirmBookingBloc
                                                            .staffData?.gender
                                                            ?.toInt() ??
                                                        0),
                                            style:
                                                kLightWhiteTextStyle.copyWith(
                                              fontSize: 14,
                                              color: ColorRes.nero,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.services,
                              style: kLightWhiteTextStyle.copyWith(
                                color: ColorRes.empress,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: confirmBookingBloc.services.length,
                            primary: false,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Services? service =
                                  confirmBookingBloc.services[index];
                              return Container(
                                color: ColorRes.smokeWhite,
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        service.title ?? ' ',
                                        style: kRegularTextStyle.copyWith(
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${AppRes.currency}${(service.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(service.price?.toInt() ?? 0, service.discount?.toInt() ?? 0).toInt()}',
                                      style: kSemiBoldThemeTextStyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          Visibility(
                            visible: confirmBookingBloc.coupon != null,
                            child: Container(
                              color: ColorRes.smokeWhite,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .couponDiscount,
                                        style: kRegularTextStyle.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              (confirmBookingBloc
                                                          .coupon?.coupon ??
                                                      '')
                                                  .toUpperCase(),
                                              style:
                                                  kBoldThemeTextStyle.copyWith(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomCircularInkWell(
                                              onTap: () {
                                                confirmBookingBloc
                                                    .removeCoupon();
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: ColorRes.silver,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    right: Radius.circular(5),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    size: 18,
                                                    color: ColorRes.mortar,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    '-\$${confirmBookingBloc.getDiscount()}',
                                    style: kSemiBoldThemeTextStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: ColorRes.themeColor10,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.subTotal,
                                  style: kRegularTextStyle.copyWith(
                                    fontSize: 17,
                                    color: ColorRes.themeColor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${AppRes.currency}${confirmBookingBloc.getSubTotalAmount()}',
                                  style: kSemiBoldThemeTextStyle.copyWith(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: confirmBookingBloc.coupon == null,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: CustomCircularInkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    CouponBottomSheet(
                                      onApplyCoupon:
                                          confirmBookingBloc.selectCoupon,
                                    ),
                                    isScrollControlled: true,
                                    ignoreSafeArea: false,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Image(
                                      image: AssetImage(AssetRes.icCoupon),
                                      height: 13,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.applyCoupon,
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.themeColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: List<Widget>.generate(
                                confirmBookingBloc
                                        .setting?.data?.taxes?.length ??
                                    0, (index) {
                              Taxes? tax = confirmBookingBloc
                                  .setting?.data?.taxes?[index];
                              return Container(
                                color: ColorRes.smokeWhite,
                                margin: const EdgeInsets.only(bottom: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      tax?.taxTitle ?? '',
                                      style: kRegularTextStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${AppRes.currency}${confirmBookingBloc.calculateTax(tax)}',
                                      style: kSemiBoldThemeTextStyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                          ),
                          Container(
                            color: ColorRes.charcoal,
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(Get.context!)!
                                      .payableAmount,
                                  style: kRegularTextStyle.copyWith(
                                    fontSize: 16,
                                    color: ColorRes.white,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${AppRes.currency}${confirmBookingBloc.getTotalPayableAmount()}',
                                  style: kRegularThemeTextStyle.copyWith(
                                    fontSize: 18,
                                    color: ColorRes.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                    child: Row(
                      children: [
                        Visibility(
                          visible: confirmBookingBloc
                                      .salonData?.isPayAfterService
                                      ?.toInt() ==
                                  1 &&
                              (confirmBookingBloc.salonData?.wallet?.toInt() ??
                                      0) >=
                                  (confirmBookingBloc.setting?.data
                                          ?.maxMinusBalanceForPostPayOption
                                          ?.toInt() ??
                                      0),
                          child: Expanded(
                            child: Container(
                              height: 55,
                              margin: const EdgeInsets.only(left: 15),
                              child: TextButton(
                                style: kButtonThemeStyle.copyWith(
                                  backgroundColor: const WidgetStatePropertyAll(
                                    ColorRes.lavender,
                                  ),
                                ),
                                onPressed: () {
                                  confirmBookingBloc.paymentType = 1;
                                  confirmBookingBloc.payNow();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.payAfterService,
                                  style: kRegularWhiteTextStyle.copyWith(
                                    color: ColorRes.themeColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 55,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextButton(
                              style: kButtonThemeStyle,
                              onPressed: () {
                                if ((confirmBookingBloc.salonUser?.data?.wallet
                                            ?.toInt() ??
                                        0) <
                                    confirmBookingBloc
                                        .getTotalPayableAmount()) {
                                  Get.bottomSheet(
                                    const RechargeWalletSheet(),
                                    isScrollControlled: true,
                                    ignoreSafeArea: false,
                                  ).then((value) {
                                    confirmBookingBloc
                                        .add(FetchArgumentsEvent());
                                  });
                                } else {
                                  confirmBookingBloc.paymentType = 0;
                                  confirmBookingBloc.payNow();
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.payNow,
                                style: kRegularWhiteTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BookingAddressWidget extends StatelessWidget {
  const BookingAddressWidget({
    super.key,
    required this.addressData,
    required this.serviceLocationType,
  });

  final AddressData? addressData;
  final int serviceLocationType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.smokeWhite,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorRes.themeColor,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 20,
            ),
            child: Text(
              serviceLocationType == 0
                  ? AppLocalizations.of(context)!.atSalon
                  : AppLocalizations.of(context)!.otherLocation,
              style: kLightWhiteTextStyle.copyWith(
                color: ColorRes.white,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: serviceLocationType == 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ((addressData?.name ?? '')).length > 19
                              ? Expanded(
                                  child: Text(
                                    (addressData?.name ?? ''),
                                    style: kMediumThemeTextStyle.copyWith(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Text(
                                  (addressData?.name ?? ''),
                                  style: kMediumThemeTextStyle.copyWith(
                                    fontSize: 17,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorRes.lavender,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ColorRes.themeColor,
                                width: .75,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                            child: Text(
                              AppRes.getAddressTypeInStringFromNumber(
                                addressData?.type?.toInt() ?? 0,
                              ),
                              style: kMediumThemeTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomCircularInkWell(
                            onTap: () async {
                              String iosUrl =
                                  'https://maps.apple.com/?q=${addressData?.latitude},${addressData?.longitude}';
                              if (Platform.isAndroid) {
                                String googleUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${addressData?.latitude},${addressData?.longitude}';
                                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                                  await launchUrl(Uri.parse(googleUrl));
                                } else {
                                  throw 'Could not launch $googleUrl';
                                }
                              } else {
                                if (await canLaunchUrl(Uri.parse(iosUrl))) {
                                  await launchUrl(Uri.parse(iosUrl));
                                } else {
                                  throw 'Could not open the map.';
                                }
                              }
                            },
                            child: Image.asset(
                              AssetRes.icNavigator2,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  addressData?.mobile ?? '',
                  style: kMediumThemeTextStyle.copyWith(
                    color: ColorRes.empress,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    addressData?.address ?? '',
                    style: kLightWhiteTextStyle.copyWith(
                      color: ColorRes.empress,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
