import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    initEmailPassword();
    on<ChangePasswordEvent>((event, emit) {});
  }

  String? email;
  String? password;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void onTapContinue() async {
    if (oldPasswordController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterOldPassword, false);
      return;
    }
    SharePref sharePref = await SharePref().init();
    String? oldPass = sharePref.getString(ConstRes.password);
    if (oldPass != oldPasswordController.text) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.oldPasswordIsWrong, false);
      return;
    }
    if (newPasswordController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterNewPassword, false);
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterConfirmPassword, false);
      return;
    }
    if (confirmPasswordController.text != newPasswordController.text) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.passwordDoesNotMatch, false);
      return;
    }
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    AppRes.showCustomLoader();
    await firebaseAuth.currentUser
        ?.updatePassword(newPasswordController.text)
        .onError((error, stackTrace) {
      Get.back();
      // AppRes.showSnackBar(
      //     AppLocalizations.of(Get.context!)!.passwordDoesNotMatch);
      FirebaseAuthException map = error as FirebaseAuthException;
      switch (map.code) {
        case "invalid-email":
        case "wrong-password":
        case "user-not-found":
          {
            AppRes.showSnackBar("Wrong email address or password.", false);
            break;
          }
        case "too-many-requests":
        case "requires-recent-login":
          {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: email ?? '', password: password ?? '')
                .then((value) {
              onTapContinue();
            });
            // AppRes.showSnackBar(
            //     "This operation is sensitive and requires recent authentication. Log in again before retrying this request",
            //     false);

            break;
          }
      }
      return Future.delayed(const Duration(seconds: 1));
    });
    // AppRes.hideCustomLoaderWithBack();
  }

  void initEmailPassword() async {
    SharePref sharePref = await SharePref().init();
    email = sharePref.getSalonUser()?.data?.identity;
    password = sharePref.getString(ConstRes.password);
  }
}
