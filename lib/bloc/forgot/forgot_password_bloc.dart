import 'package:cutfx/utils/app_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ContinueForgotPasswordEvent>((event, emit) {
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
      AppRes.showCustomLoader();
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailTextController.text)
          .then((value) {
        AppRes.hideCustomLoaderWithBack();
      });
    });
  }

  TextEditingController emailTextController = TextEditingController();
}
