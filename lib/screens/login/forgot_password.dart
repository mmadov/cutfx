import 'package:cutfx/bloc/forgot/forgot_password_bloc.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class ForgotPasswordBottomSheet extends StatelessWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SafeArea(
          child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
            builder: (context, state) {
              ForgotPasswordBloc forgotPasswordBloc =
                  context.read<ForgotPasswordBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.forgotYourPassword,
                        style: kBoldThemeTextStyle,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            color: ColorRes.lavender,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.close_rounded,
                            color: ColorRes.themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .enterYourEmailAddressOnWhichWeWillSendYouTheLinkToResetThePassword,
                    style: kRegularTextStyle,
                  ),
                  const Spacer(),
                  TextWithTextFieldSmokeWhiteWidget(
                    title: AppLocalizations.of(context)!.emailAddress,
                    controller: forgotPasswordBloc.emailTextController,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: TextButton(
                      style: kButtonThemeStyle,
                      onPressed: () {
                        forgotPasswordBloc.add(ContinueForgotPasswordEvent());
                      },
                      child: Text(
                        AppLocalizations.of(context)!.continue_,
                        style: kRegularWhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
