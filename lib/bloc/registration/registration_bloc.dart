import 'package:cutfx/utils/app_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<ContinueRegistrationEvent>((event, emit) {
      if (fullNameTextController.text.isEmpty) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseEnterFullname, false);
        return;
      }
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
      if (confirmPasswordTextController.text.isEmpty) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.pleaseEnterConfirmPassword,
            false);
        return;
      }
      if (confirmPasswordTextController.text != passwordTextController.text) {
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.passwordDoesNotMatch, false);
        return;
      }
      AppRes.showCustomLoader();
      firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      )
          .then((value) {
        if (value.user != null) {
          User? user = value.user;
          if (user != null && !user.emailVerified) {
            user.sendEmailVerification();
            user.updateDisplayName(fullNameTextController.text);
            // ApiService().registerUser(
            //     email: emailTextController.text,
            //     fullname: fullNameTextController.text,
            //     loginType: 0);
            AppRes.hideCustomLoaderWithBack();
          }
        }
      }).onError((error, stackTrace) {
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
          case "user-disabled":
            {
              AppRes.showSnackBar("This account is disabled", false);
              break;
            }
          case "email-already-in-use":
            {
              AppRes.showSnackBar(
                  "The email address is already in use by another account",
                  false);
              break;
            }
        }
        return Future.delayed(const Duration(seconds: 1));
      });
    });
  }

  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}
