import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AppointmentBookedScreen extends StatelessWidget {
  const AppointmentBookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: const BoxDecoration(
              color: ColorRes.themeColor20,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.appointmentBooked,
                    style: kBoldThemeTextStyle.copyWith(
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    AssetRes.icRoundVerifiedBig,
                    width: 110,
                    height: 110,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            AppLocalizations.of(context)!.appointmentId,
            style: kRegularTextStyle.copyWith(
              fontSize: 18,
              color: ColorRes.themeColor,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${Get.arguments}'.toUpperCase(),
            style: kBoldThemeTextStyle.copyWith(
              fontSize: 19,
              color: ColorRes.themeColor,
              fontFamily: AssetRes.fnProductSansBlack,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            AppLocalizations.of(context)!
                .yourAppointmentnhasBeenBookedSuccessfully,
            textAlign: TextAlign.center,
            style: kBoldThemeTextStyle.copyWith(
              fontSize: 20,
              color: ColorRes.mortar,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!
                .checkAppointmentsTabnforAllYourUpcomingAppointments,
            textAlign: TextAlign.center,
            style: kRegularTextStyle.copyWith(
              color: ColorRes.charcoal50,
              fontSize: 17,
            ),
          ),
          const Spacer(),
          CustomCircularInkWell(
            onTap: () {
              Get.offAll(() => MainScreen());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: ColorRes.themeColor,
              alignment: Alignment.center,
              child: SafeArea(
                top: false,
                child: Text(
                  AppLocalizations.of(context)!.myBookings,
                  style: kSemiBoldTextStyle.copyWith(
                    fontSize: 17,
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
