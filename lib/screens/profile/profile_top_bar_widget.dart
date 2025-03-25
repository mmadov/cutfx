import 'package:cutfx/bloc/profile/profile_bloc.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/edit_profile_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ProfileTopBarWidget extends StatelessWidget {
  const ProfileTopBarWidget({
    super.key,
    required this.onMenuClick,
    this.salonUser,
  });
  final SalonUser? salonUser;
  final Function()? onMenuClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.themeColor5,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                BgRoundImageWidget(
                  image: AssetRes.icMenu,
                  imagePadding: 8,
                  onTap: onMenuClick,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.profile,
                  style: kLightWhiteTextStyle.copyWith(
                    fontSize: 20,
                    color: ColorRes.themeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorRes.themeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: FadeInImage.assetNetwork(
                          placeholder: '1',
                          image:
                              '${ConstRes.itemBaseUrl}${salonUser?.data?.profileImage ?? ''}',
                          fit: BoxFit.cover,
                          imageErrorBuilder: errorBuilderForImage,
                          placeholderErrorBuilder: loadingImage,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        salonUser?.data?.fullname?.capitalize ?? '',
                        style: kBoldThemeTextStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.totalBookings,
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              ':',
                              style: kThinWhiteTextStyle.copyWith(
                                color: ColorRes.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            '${salonUser?.data?.bookingsCount ?? 0}',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      CustomCircularInkWell(
                        onTap: () {
                          Get.to(() => const EditProfileScreen())
                              ?.then((value) {
                            if (context.mounted) {
                              context
                                  .read<ProfileBloc>()
                                  .add(FetchUserDataEvent());
                            }
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorRes.themeColor5,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.editDetails,
                              style: kRegularThemeTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
