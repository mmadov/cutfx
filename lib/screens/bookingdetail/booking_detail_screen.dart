import 'dart:math';

import 'package:cutfx/bloc/bookingdetail/booking_detail_bloc.dart';
import 'package:cutfx/model/bookings/booking.dart';
import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/bookingdetail/add_rating_bottom_sheet.dart';
import 'package:cutfx/screens/bookingdetail/my_qr_bottom_sheet.dart';
import 'package:cutfx/screens/bookingdetail/reschedule_bottom_sheet.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/payment/make_payment_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  bool orderIsStart = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingDetailBloc(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: ColorRes.smokeWhite,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 15),
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCircularInkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Image(
                          image: AssetImage(AssetRes.icBack),
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.bookingDetails,
                                style: kBoldThemeTextStyle,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                Get.arguments ?? '',
                                style: kRegularTextStyle.copyWith(
                                  fontSize: 14,
                                  color: ColorRes.empress,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          BgRoundImageWidget(
                            image: AssetRes.icQrCode,
                            imagePadding: 10,
                            bgColor: ColorRes.smokeWhite1,
                            onTap: () {
                              Get.bottomSheet(
                                MyQrCodeBottomSheet(
                                  bookingId: Get.arguments ?? '',
                                ),
                                ignoreSafeArea: false,
                                isScrollControlled: true,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<BookingDetailBloc, BookingDetailState>(
              builder: (context, state) {
                BookingDetailBloc bookingDetailsBloc =
                    context.read<BookingDetailBloc>();
                BookingData? bookingData =
                    bookingDetailsBloc.bookingDetails?.data;
                return bookingData == null
                    ? const Expanded(
                        child: LoadingData(),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              color: AppRes.getColorByStatus(
                                  bookingData.status?.toInt() ?? 0),
                              child: Text(
                                AppRes.getTextByStatus(
                                    bookingData.status?.toInt() ?? 0),
                                style: kRegularTextStyle.copyWith(
                                  color: AppRes.getTextColorByStatus(
                                      bookingData.status?.toInt() ?? 0),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: bookingData.status == 2 &&
                                          bookingData.isRated != 1,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.pumpkin15,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 18),
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .rateThisSaloon,
                                                  style: kSemiBoldTextStyle
                                                      .copyWith(
                                                    color: ColorRes.pumpkin,
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .shareYourExperienceWithUs,
                                                  style: kLightWhiteTextStyle
                                                      .copyWith(
                                                    color: ColorRes.pumpkin,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            CustomCircularInkWell(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  AddRatingBottomSheet(
                                                      bookingId: bookingData
                                                              .bookingId ??
                                                          ''),
                                                  isScrollControlled: true,
                                                  ignoreSafeArea: false,
                                                ).then((value) {
                                                  if (context.mounted) {
                                                    context
                                                        .read<
                                                            BookingDetailBloc>()
                                                        .add(
                                                            FetchBookingDetailEvent());
                                                  }
                                                  setState(() {});
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: ColorRes.pumpkin15,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .rateNow,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    color: ColorRes.pumpkin,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / .35,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 15,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                left: Radius.circular(10),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1 / 1,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: '1',
                                                  image:
                                                      '${ConstRes.itemBaseUrl}${bookingData.salonData?.images != null && bookingData.salonData!.images!.isNotEmpty ? bookingData.salonData?.images![0].image : ''}',
                                                  fit: BoxFit.cover,
                                                  placeholderErrorBuilder:
                                                      loadingImage,
                                                  imageErrorBuilder:
                                                      errorBuilderForImage,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      bookingData.salonData
                                                              ?.salonName ??
                                                          '',
                                                      style: kSemiBoldTextStyle
                                                          .copyWith(
                                                        color: ColorRes.nero,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      bookingData.salonData
                                                              ?.salonAddress ??
                                                          '',
                                                      style: kThinWhiteTextStyle
                                                          .copyWith(
                                                        color:
                                                            ColorRes.titleText,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            ColorRes.pumpkin15,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                      ),
                                                      width: 60,
                                                      height: 26,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            bookingData
                                                                    .salonData
                                                                    ?.rating
                                                                    ?.toStringAsFixed(
                                                                        1) ??
                                                                '',
                                                            style:
                                                                kRegularTextStyle
                                                                    .copyWith(
                                                              color: ColorRes
                                                                  .pumpkin,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Icon(
                                                            Icons.star_rounded,
                                                            color: ColorRes
                                                                .pumpkin,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: ColorRes.smokeWhite2,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .date,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes.formatDate(
                                                        AppRes.parseDate(
                                                          bookingData.date ??
                                                              '',
                                                          pattern: 'yyyy-MM-dd',
                                                          isUtc: false,
                                                        ),
                                                        pattern: 'dd MMM, yyyy',
                                                        isUtc: false,
                                                      ),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .time,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes
                                                          .convert24HoursInto12Hours(
                                                              bookingData.time),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .duration,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes
                                                          .convertTimeForService(
                                                        int.parse(bookingData
                                                                .duration ??
                                                            '0'),
                                                      ),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
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
                                              AppLocalizations.of(context)!
                                                  .serviceLocation,
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          BookingAddressWidget(
                                            addressData:
                                                bookingData.serviceAddress,
                                            serviceLocationType: bookingData
                                                    .serviceLocation
                                                    ?.toInt() ??
                                                0,
                                          ),
                                          Visibility(
                                            visible: bookingData.staff != null,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 20,
                                                bottom: 10,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .barber,
                                                style: kLightWhiteTextStyle
                                                    .copyWith(
                                                  color: ColorRes.empress,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: bookingData.staff != null,
                                            child: Container(
                                              color: ColorRes.smokeWhite,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  ClipOval(
                                                    child: Container(
                                                      height: 55,
                                                      width: 55,
                                                      color:
                                                          ColorRes.smokeWhite2,
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        image:
                                                            '${ConstRes.itemBaseUrl}${bookingDetailsBloc.bookingDetails?.data?.staff?.photo}',
                                                        fit: BoxFit.cover,
                                                        placeholder: '1',
                                                        placeholderErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  AssetRes
                                                                      .icUser),
                                                            ),
                                                          );
                                                        },
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  AssetRes
                                                                      .icUser),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            bookingDetailsBloc
                                                                    .bookingDetails
                                                                    ?.data
                                                                    ?.staff
                                                                    ?.name ??
                                                                '',
                                                            style:
                                                                kRegularThemeTextStyle
                                                                    .copyWith(
                                                              color:
                                                                  ColorRes.nero,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            AppRes.getGenderTypeInStringFromNumber(
                                                                context,
                                                                bookingDetailsBloc
                                                                        .bookingDetails
                                                                        ?.data
                                                                        ?.staff
                                                                        ?.gender
                                                                        ?.toInt() ??
                                                                    0),
                                                            style:
                                                                kLightWhiteTextStyle
                                                                    .copyWith(
                                                              fontSize: 14,
                                                              color: ColorRes
                                                                  .empress,
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
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: bookingData.staff == null
                                                  ? 15
                                                  : 5,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .services,
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(
                                                bookingData.services?.length ??
                                                    0, (index) {
                                              Services? serviceData =
                                                  bookingData.services?[index];
                                              return Container(
                                                color: ColorRes.smokeWhite,
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        serviceData?.title ??
                                                            '',
                                                        style: kRegularTextStyle
                                                            .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${AppRes.currency}${(serviceData?.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(serviceData?.price?.toInt() ?? 0, serviceData?.discount?.toInt() ?? 0).toInt()}',
                                                      style:
                                                          kSemiBoldThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                          Visibility(
                                            visible:
                                                bookingData.isCouponApplied ==
                                                    1,
                                            child: Container(
                                              color: ColorRes.smokeWhite,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .couponDiscount,
                                                        style: kRegularTextStyle
                                                            .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: ColorRes
                                                              .smokeWhite1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(5),
                                                          ),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                          vertical: 3,
                                                        ),
                                                        margin: const EdgeInsets
                                                            .only(
                                                          top: 5,
                                                        ),
                                                        child: Text(
                                                          bookingData
                                                                  .getOrderSummary()
                                                                  .coupon
                                                                  ?.coupon
                                                                  ?.toUpperCase() ??
                                                              '',
                                                          style:
                                                              kBoldThemeTextStyle
                                                                  .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '-\$${bookingData.getOrderSummary().discountAmount}',
                                                    style:
                                                        kSemiBoldThemeTextStyle
                                                            .copyWith(
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: ColorRes.themeColor10,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .subTotal,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 17,
                                                    color: ColorRes.themeColor,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '${AppRes.currency}${bookingData.getOrderSummary().subtotal}',
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(
                                                bookingData
                                                        .getOrderSummary()
                                                        .taxes
                                                        ?.length ??
                                                    0, (index) {
                                              Taxes tax = bookingData
                                                  .getOrderSummary()
                                                  .taxes![index];
                                              return Container(
                                                color: ColorRes.smokeWhite,
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      tax.taxTitle ?? '',
                                                      style: kRegularTextStyle
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '${AppRes.currency}${tax.taxAmount}',
                                                      style:
                                                          kSemiBoldThemeTextStyle
                                                              .copyWith(
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
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 15,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .payableAmount,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.white,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '${AppRes.currency}${bookingData.getOrderSummary().payableAmount}',
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: ColorRes.lavender,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                bottom: Radius.circular(20),
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .paymentType,
                                                  style: kRegularThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  AppRes.getPaymentType(
                                                      bookingData.paymentType),
                                                  style: kMediumThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: bookingData.status == 0 ||
                                          bookingData.status == 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: CustomCircularInkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    builder: (context) {
                                                      return ReScheduleBottomSheet(
                                                        bookingDetailBloc:
                                                            bookingDetailsBloc,
                                                      );
                                                    },
                                                    context: context,
                                                    isScrollControlled: true,
                                                  ).then((value) {
                                                    if (context.mounted) {
                                                      context
                                                          .read<
                                                              BookingDetailBloc>()
                                                          .add(
                                                              FetchBookingDetailEvent());
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: ColorRes.smokeWhite2,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .reschedule,
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: CustomCircularInkWell(
                                                onTap: () {
                                                  context
                                                      .read<BookingDetailBloc>()
                                                      .cancelBooking();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        ColorRes.bitterSweet10,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .cancel,
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        color: ColorRes
                                                            .bitterSweet,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: bookingData.isRated == 1,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .yourReview,
                                              style: kRegularThemeTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RatingBar(
                                              initialRating: bookingData
                                                      .review?.rating
                                                      ?.toDouble() ??
                                                  0,
                                              ignoreGestures: true,
                                              ratingWidget: RatingWidget(
                                                full: const Icon(
                                                  Icons.star_rounded,
                                                  color: ColorRes.sun,
                                                ),
                                                half: const Icon(
                                                  Icons.star_rounded,
                                                ),
                                                empty: const Icon(
                                                  Icons.star_rounded,
                                                  color: ColorRes.darkGray,
                                                ),
                                              ),
                                              onRatingUpdate: (value) {},
                                              itemSize: 30,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              bookingData.review?.comment ?? '',
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
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
                          ],
                        ),
                      );
              },
            ),
            BlocBuilder<BookingDetailBloc, BookingDetailState>(
              builder: (context, state) {
                BookingData? bookingData =
                    context.read<BookingDetailBloc>().bookingDetails?.data;
                return SafeArea(
                  top: false,
                  child: Visibility(
                    visible: bookingData?.status == 1,
                    child: Container(
                      color: ColorRes.smokeWhite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.completionOtp,
                                style: kRegularTextStyle,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                bookingData?.completionOtp?.toString() ?? '',
                                style: kSemiBoldThemeTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .pleaseProvideThisOtpAtSalonWhenAskedOnlyAfter,
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.empress,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
