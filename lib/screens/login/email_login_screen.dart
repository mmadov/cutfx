import 'package:cutfx/bloc/emaillogin/email_login_bloc.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/screens/login/forgot_password.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailLoginBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.themeColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SafeArea(
                child: BlocBuilder<EmailLoginBloc, EmailLoginState>(
                  builder: (context, state) {
                    EmailLoginBloc emailLoginBloc =
                        context.read<EmailLoginBloc>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const AppLogo(
                          textSize: 30,
                        ),
                        Text(
                          AppLocalizations.of(context)!.signInToContinue,
                          style: kSemiBoldWhiteTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .findAndBookHairCutMassageSpaWaxingColoringServicesAnytime,
                          style: kLightWhiteTextStyle,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TextWithTextFieldWidget(
                          title: AppLocalizations.of(context)!.emailAddress,
                          controller: emailLoginBloc.emailTextController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextWithTextFieldWidget(
                            title: AppLocalizations.of(context)!.password,
                            isPassword: true,
                            controller: emailLoginBloc.passwordTextController),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: double.infinity,
                          height: 55,
                          child: TextButton(
                            style: kButtonWhiteStyle,
                            onPressed: () {
                              emailLoginBloc.add(ContinueLoginEvent());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.continue_,
                              style: kThemeButtonTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const EmailRegistrationScreen())?.then(
                              (value) {
                                SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle.light,
                                );
                              },
                            );
                          },
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              AppLocalizations.of(context)!.newUserRegisterHere,
                              style: kRegularWhiteTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(const ForgotPasswordBottomSheet());
                          },
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword_,
                              style: kRegularWhiteTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: BackButton(
                  color: ColorRes.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWithTextFieldWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;

  const TextWithTextFieldWidget({
    super.key,
    required this.title,
    this.isPassword,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kRegularWhiteTextStyle,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            style: kRegularWhiteTextStyle,
            obscureText: isPassword ?? false,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}
