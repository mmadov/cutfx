import 'package:cutfx/bloc/profile/profile_bloc.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/address/manage_my_addresses.dart';
import 'package:cutfx/screens/booking/profile_booking_screen.dart';
import 'package:cutfx/screens/help&faq/help_and_faq_screen.dart';
import 'package:cutfx/screens/payoutHistory/payout_history_screen.dart';
import 'package:cutfx/screens/profile/chnage_password_bottom.dart';
import 'package:cutfx/screens/profile/delete_account_bottom.dart';
import 'package:cutfx/screens/profile/profile_top_bar_widget.dart';
import 'package:cutfx/screens/wallet/wallet_screen.dart';
import 'package:cutfx/screens/web/web_view_screen.dart';
import 'package:cutfx/screens/welcome/welcome_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final Function()? onMenuClick;

  const ProfileScreen({super.key, this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          SalonUser? salonUser =
              state is UserDataFoundState ? state.salonUser : null;
          return salonUser != null
              ? Column(
                  children: [
                    ProfileTopBarWidget(
                      onMenuClick: onMenuClick,
                      salonUser: salonUser,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: ColorRes.smokeWhite,
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .pushNotification,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: ColorRes.empress,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .keepItOnIfYouWantToReceiveNotifications,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: ColorRes.subTitleText,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ToggleButton(
                                    value: salonUser.data?.isNotification == 1,
                                    onValueChange: (isEnable) {
                                      ApiService().editUserDetails(
                                          isNotification: isEnable);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.wallet,
                              onTap: () {
                                Get.to(() => const WalletScreen());
                              },
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.bookings,
                              onTap: () {
                                Get.to(() => const ProfileBookingScreen());
                              },
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.addresses,
                              onTap: () {
                                Get.to(() => const ManageMyAddressesScreen());
                              },
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!
                                  .withdrawRequests,
                              onTap: () {
                                Get.to(() => const PayoutHistoryScreen());
                              },
                            ),
                            Visibility(
                              visible: salonUser.data?.loginType == 3,
                              child: ProfileMenuItemWidget(
                                title: AppLocalizations.of(context)!
                                    .changePassword,
                                onTap: () {
                                  Get.bottomSheet(
                                    const ChangePasswordBottomSheet(),
                                    ignoreSafeArea: false,
                                    isScrollControlled: true,
                                  );
                                },
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.termsOfUse,
                              onTap: () {
                                Get.to(
                                  () => const WebViewScreen(),
                                  arguments:
                                      AppLocalizations.of(context)!.termsOfUse,
                                );
                              },
                            ),
                            ProfileMenuItemWidget(
                              title:
                                  AppLocalizations.of(context)!.privacyPolicy,
                              onTap: () {
                                Get.to(
                                  () => const WebViewScreen(),
                                  arguments: AppLocalizations.of(context)!
                                      .privacyPolicy,
                                );
                              },
                            ),
                            ProfileMenuItemWidget(
                              title: AppLocalizations.of(context)!.help_FAQ,
                              onTap: () {
                                Get.to(() => const HelpFaqScreen());
                              },
                            ),
                            Visibility(
                              visible: ConstRes.userIdValue != -1,
                              child: CustomCircularInkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                    ConfirmationBottomSheet(
                                      title: AppLocalizations.of(context)!
                                          .deleteMyAccount,
                                      description: AppLocalizations.of(context)!
                                          .deleteDesc,
                                      buttonText: AppLocalizations.of(context)!
                                          .continue_,
                                      onButtonClick: () async {
                                        AppRes.showCustomLoader();
                                        await ApiService()
                                            .deleteMyUserAccount();
                                        SharePref sharedPref =
                                            await SharePref().init();
                                        sharedPref.clear();
                                        FirebaseAuth.instance.signOut();
                                        AppRes.hideCustomLoader();
                                        Get.offAll(() => const WelComeScreen());
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: ColorRes.bitterSweet10,
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .deleteMyAccount,
                                    style: kLightWhiteTextStyle.copyWith(
                                      color: ColorRes.bitterSweet,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const LoadingData();
        },
      ),
    );
  }
}

class ProfileMenuItemWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const ProfileMenuItemWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        color: ColorRes.smokeWhite,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          title,
          style: kLightWhiteTextStyle.copyWith(
            color: ColorRes.empress,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final Function(bool isEnable)? onValueChange;
  final bool? value;

  const ToggleButton({
    super.key,
    this.onValueChange,
    this.value,
  });

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool buttonIsActive = false;

  @override
  void initState() {
    buttonIsActive = widget.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: buttonIsActive,
      activeColor: ColorRes.themeColor,
      onChanged: (value) {
        buttonIsActive = value;
        widget.onValueChange?.call(value);
        setState(() {});
      },
    );
  }
}
