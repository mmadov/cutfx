import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'email_login_event.dart';
part 'email_login_state.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  EmailLoginBloc() : super(EmailLoginInitial()) {
    on<ContinueLoginEvent>((event, emit) {
      if (emailTextController.text.isEmpty) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseEnterEmailAddress, false);
        return;
      }
      if (!emailTextController.text.isEmail) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseEnterValidEmailAddress,
            false);
        return;
      }
      if (passwordTextController.text.isEmpty) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseEnterPassword, false);
        return;
      }
      AppRes.showCustomLoader();
      firebaseAuth
          .signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      )
          .then((value) async {
        if (value.user != null) {
          User? user = value.user;
          // if (user != null && !user.emailVerified) {
          //   AppRes.showSnackBar(
          //     AppLocalizations.of(Get.context!)!.pleaseVerifyEmailFirst,
          //   );
          // }
          SharePref sharePref = await SharePref().init();
          sharePref.saveString(ConstRes.password, passwordTextController.text);
          AppRes.loginWithFirebase(user, 3);
        } else {}
      }).catchError((error) {
        var errorCode = error.code;
        if (errorCode == 'firebase_auth/wrong-password' ||
            errorCode == 'wrong-password') {
          AppRes.hideCustomLoader();
          AppRes.showSnackBar(
              AppLocalizations.of(Get.context!)!.wrongPassword, false);
        } else if (errorCode == 'firebase_auth/user-not-found' ||
            errorCode == 'user-not-found') {
          AppRes.hideCustomLoader();
          AppRes.showSnackBar(
              AppLocalizations.of(Get.context!)!.pleaseRegistrationFirst,
              false);
        }
      });
    });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
}
