import 'package:cutfx/bloc/registration/registration_bloc.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class EmailRegistrationScreen extends StatelessWidget {
  const EmailRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Scaffold(
        body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            RegistrationBloc registrationBloc =
                context.read<RegistrationBloc>();
            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCircularInkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Image(
                            image: AssetImage(AssetRes.icBack),
                            height: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.emailRegistration,
                          style: kBoldThemeTextStyle,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .enterYourDetailsAndCompleteProfileForBetterExperience,
                          style: kLightWhiteTextStyle.copyWith(
                            color: ColorRes.empress,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            TextWithTextFieldSmokeWhiteWidget(
                              title: AppLocalizations.of(context)!.fullName,
                              controller:
                                  registrationBloc.fullNameTextController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWithTextFieldSmokeWhiteWidget(
                              title: AppLocalizations.of(context)!.emailAddress,
                              controller: registrationBloc.emailTextController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWithTextFieldSmokeWhiteWidget(
                              isPassword: true,
                              title: AppLocalizations.of(context)!.password,
                              controller:
                                  registrationBloc.passwordTextController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWithTextFieldSmokeWhiteWidget(
                              title:
                                  AppLocalizations.of(context)!.confirmPassword,
                              controller: registrationBloc
                                  .confirmPasswordTextController,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        style: kButtonThemeStyle,
                        onPressed: () {
                          context
                              .read<RegistrationBloc>()
                              .add(ContinueRegistrationEvent());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.continue_,
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
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

class TextWithTextFieldSmokeWhiteWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const TextWithTextFieldSmokeWhiteWidget({
    super.key,
    required this.title,
    this.isPassword,
    this.controller,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kLightWhiteTextStyle.copyWith(
            color: ColorRes.black,
            fontSize: 16,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          height: 55,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            style: kRegularTextStyle.copyWith(
              color: ColorRes.charcoal50,
            ),
            keyboardType: textInputType,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}
