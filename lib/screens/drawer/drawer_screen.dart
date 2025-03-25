import 'dart:ui';

import 'package:cutfx/screens/booking/profile_booking_screen.dart';
import 'package:cutfx/screens/changelanguage/change_language.dart';
import 'package:cutfx/screens/help&faq/help_and_faq_screen.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/screens/salononmap/explore_salon_on_map.dart';
import 'package:cutfx/screens/web/web_view_screen.dart';
import 'package:cutfx/screens/welcome/welcome_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../profile/delete_account_bottom.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const TopBarDrawerWidget(),
          DrawerMenuWidget(
            image: AssetRes.icLocation,
            title: AppLocalizations.of(context)!.exploreSalonsOnMap,
            imagePadding: 2,
            onTap: () {
              Get.to(
                () => const SalonOnMapScreen(),
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icLanguage,
            title: AppLocalizations.of(context)!.changeLanguage,
            imagePadding: 4,
            onTap: () {
              Get.to(
                () => const ChangeLanguageScreen(),
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icBooking,
            title: AppLocalizations.of(context)!.bookings,
            onTap: () {
              if (ConstRes.userIdValue == -1) {
                Get.to(() => const LoginOptionScreen());
                return;
              }
              Get.to(
                () => const ProfileBookingScreen(),
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icHelp,
            title: AppLocalizations.of(context)!.help_FAQ,
            imagePadding: 3,
            onTap: () {
              Get.to(
                () => const HelpFaqScreen(),
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icInfo,
            title: AppLocalizations.of(context)!.aboutUs,
            imagePadding: 3,
            onTap: () {
              Get.to(
                () => const WebViewScreen(),
                arguments: AppLocalizations.of(context)!.aboutUs,
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icInfo,
            title: AppLocalizations.of(context)!.termsOfUse,
            imagePadding: 3,
            onTap: () {
              Get.to(
                () => const WebViewScreen(),
                arguments: AppLocalizations.of(context)!.termsOfUse,
              );
            },
          ),
          DrawerMenuWidget(
            image: AssetRes.icInfo,
            title: AppLocalizations.of(context)!.privacyPolicy,
            imagePadding: 3,
            onTap: () {
              Get.to(
                () => const WebViewScreen(),
                arguments: AppLocalizations.of(context)!.privacyPolicy,
              );
            },
          ),
          Visibility(
            visible: ConstRes.userIdValue != -1,
            child: CustomCircularInkWell(
              onTap: () {
                Get.bottomSheet(
                  ConfirmationBottomSheet(
                    title: AppLocalizations.of(context)!.logOut,
                    description: AppLocalizations.of(context)!.logoutDec,
                    buttonText: AppLocalizations.of(context)!.continue_,
                    onButtonClick: () async {
                      AppRes.showCustomLoader();
                      await ApiService().editUserDetails(deviceToken: 'none');
                      FirebaseAuth.instance.signOut();
                      AppRes.hideCustomLoader();
                      SharePref sharedPref = await SharePref().init();
                      sharedPref.clear();
                      Get.offAll(const WelComeScreen());
                    },
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(2),
                      child: const Image(
                        image: AssetImage(AssetRes.icLogOut),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logOut,
                      style: kLightWhiteTextStyle.copyWith(
                        color: ColorRes.bitterSweet,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerMenuWidget extends StatelessWidget {
  final String image;
  final String title;
  final double? imagePadding;
  final Function()? onTap;

  const DrawerMenuWidget({
    super.key,
    required this.image,
    required this.title,
    this.imagePadding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              padding: EdgeInsets.all(imagePadding ?? 0),
              child: Image(
                image: AssetImage(image),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                title,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.empress,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopBarDrawerWidget extends StatelessWidget {
  const TopBarDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            const Image(
              image: AssetImage(AssetRes.icHorizontalBg),
              height: 200,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
                tileMode: TileMode.mirror,
              ),
              child: Container(
                color: ColorRes.themeColor30,
                width: double.infinity,
                child: SafeArea(
                  bottom: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppLogo(textSize: 24),
                        Text(
                          AppLocalizations.of(context)!
                              .findAndBookHairCutMassageSpaWaxingColoringServicesAnytime,
                          style: kLightWhiteTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
