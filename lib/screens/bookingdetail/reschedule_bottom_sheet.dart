import 'package:cutfx/bloc/bookingdetail/booking_detail_bloc.dart';
import 'package:cutfx/bloc/reschedule/re_schedule_bloc.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../booking/confirm_booking.dart';

class ReScheduleBottomSheet extends StatelessWidget {
  final BookingDetailBloc bookingDetailBloc;

  const ReScheduleBottomSheet({
    super.key,
    required this.bookingDetailBloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReScheduleBloc(),
      child: BlocBuilder<ReScheduleBloc, ReScheduleState>(
        builder: (context, state) {
          ReScheduleBloc reScheduleBloc = context.read<ReScheduleBloc>();
          if (reScheduleBloc.bookingDetails == null) {
            reScheduleBloc.bookingDetails = bookingDetailBloc.bookingDetails;
            reScheduleBloc.staffData =
                bookingDetailBloc.bookingDetails?.data?.staff;
            reScheduleBloc.add(UpdateDataEvent());
          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            height: Get.height / 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.reschedule,
                      style: kBoldThemeTextStyle,
                    ),
                    const Spacer(),
                    const CloseButtonWidget(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.barber,
                          style: kLightWhiteTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.empress,
                          ),
                        ),
                        ItemStaff(
                          staffData: reScheduleBloc.staffData,
                          onTapChange: () {
                            reScheduleBloc.selectStaff(reScheduleBloc);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.selectDate,
                              style: kLightWhiteTextStyle.copyWith(
                                fontSize: 16,
                                color: ColorRes.empress,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${AppRes.convertMonthNumberToName(context, reScheduleBloc.month)} ${reScheduleBloc.year}',
                              style: kMediumTextStyle.copyWith(
                                fontSize: 17,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            itemCount: reScheduleBloc.days.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DateTime day = reScheduleBloc.days[index];
                              bool isSelected = day.day == reScheduleBloc.day &&
                                  day.month == reScheduleBloc.month;
                              return CustomCircularInkWell(
                                onTap: () {
                                  reScheduleBloc.onClickCalenderDay(
                                      day, reScheduleBloc);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorRes.themeColor
                                        : ColorRes.smokeWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1.1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('EE')
                                              .format(day)
                                              .toUpperCase(),
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                            color: isSelected
                                                ? ColorRes.white
                                                : ColorRes.charcoal,
                                            fontSize: 12,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Text(
                                          day.day.toString(),
                                          style: kBoldThemeTextStyle.copyWith(
                                            fontSize: 20,
                                            color: isSelected
                                                ? ColorRes.white
                                                : ColorRes.charcoal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.selectTime,
                          style: kLightWhiteTextStyle.copyWith(
                            fontSize: 16,
                            color: ColorRes.empress,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 70,
                          child: state is ReScheduleInitial
                              ? const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : reScheduleBloc.slots.isEmpty
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        color: ColorRes.smokeWhite,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .noSlotsAvailable,
                                          style:
                                              kRegularEmpressTextStyle.copyWith(
                                            color: ColorRes.darkGray,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: reScheduleBloc.slots.length,
                                      padding: const EdgeInsets.all(0),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        SlotData? slotData =
                                            reScheduleBloc.slots[index];
                                        DateTime dateTime = DateTime(
                                            DateTime.now().year,
                                            reScheduleBloc.month,
                                            reScheduleBloc.day,
                                            int.parse(slotData.time
                                                    ?.substring(0, 2) ??
                                                '0'),
                                            int.parse(slotData.time
                                                    ?.substring(2, 4) ??
                                                '0'));
                                        DateTime current = DateTime.now();
                                        int hour =
                                            reScheduleBloc.selectedTime?.hour ??
                                                0;
                                        int min = reScheduleBloc
                                                .selectedTime?.minute ??
                                            0;
                                        String selectedTime =
                                            '${hour < 10 ? '0$hour' : '$hour'}${min < 10 ? '0$min' : '$min'}';
                                        bool isAvailable =
                                            slotData.available == true &&
                                                dateTime
                                                        .difference(current)
                                                        .inMinutes >
                                                    5;
                                        bool isSelected =
                                            selectedTime == slotData.time;
                                        return CustomCircularInkWell(
                                          onTap: () {
                                            if (!isAvailable) {
                                              return;
                                            }
                                            reScheduleBloc.selectedTime =
                                                TimeOfDay(
                                              hour: AppRes.getHourFromTime(AppRes
                                                  .convert24HoursInto12Hours(
                                                      slotData.time)),
                                              minute: int.parse(
                                                AppRes.getMinFromTime(AppRes
                                                    .convert24HoursInto12Hours(
                                                        slotData.time)),
                                              ),
                                            );
                                            reScheduleBloc
                                                .add(UpdateDataEvent());
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 95,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? ColorRes.themeColor
                                                      : ColorRes.smokeWhite,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                margin: const EdgeInsets.only(
                                                    right: 8, bottom: 3),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  AppRes
                                                      .convert24HoursInto12Hours(
                                                          slotData.time),
                                                  style: kBoldWhiteTextStyle
                                                      .copyWith(
                                                    color: isSelected
                                                        ? ColorRes.white
                                                        : !isAvailable
                                                            ? ColorRes.darkGray
                                                            : ColorRes.charcoal,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                !isAvailable
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .notAvailable
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .available,
                                                style:
                                                    kRegularTextStyle.copyWith(
                                                  color: !isAvailable
                                                      ? ColorRes.darkGray
                                                      : ColorRes.islamicGreen,
                                                  fontSize: 13,
                                                  letterSpacing: .4,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: TextButton(
                    style: kButtonThemeStyle,
                    onPressed: () {
                      reScheduleBloc.onSubmitClick();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.submit,
                      style: kRegularWhiteTextStyle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onSubmitClick() async {
    // AppRes.showCustomLoader();
    // RestResponse response = await ApiService().rescheduleBooking(
    //   bookingDetailBloc.bookingId ?? '',
    //   AppRes.formatDate(selectedDate ?? DateTime.now(), pattern: 'yyyy-MM-dd'),
    //   '${0.convert2Digits(selectedTime?.hour)}${0.convert2Digits(selectedTime?.minute)}',
    // );
    // AppRes.hideCustomLoaderWithBack();
    // AppRes.showSnackBar(response.message ?? '', response.status ?? false);
  }
}
