import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawBloc() : super(WithdrawInitial()) {
    on<FetchWalletBalanceEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      userData = sharePref.getSalonUser()?.data;
      emit(WithdrawDataFoundState());
    });
    add(FetchWalletBalanceEvent());
  }

  UserData? userData;
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController reAccountNumberController = TextEditingController();
  TextEditingController holdersNameController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();

  void tapOnContinue() async {
    if (bankNameController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.enterBankName, false);
      return;
    }
    if (accountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.enterAccountNumber, false);
      return;
    }
    if (reAccountNumberController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.enterReaccountNumber, false);
      return;
    }
    if (reAccountNumberController.text != accountNumberController.text) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.accountNumberDoestMatched, false);
      return;
    }
    if (holdersNameController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.enterHoldersName, false);
      return;
    }
    if (swiftCodeController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.enterSwiftCode, false);
      return;
    }
    AppRes.showCustomLoader();
    await ApiService().submitUserWithdrawRequest(
      bankTitle: bankNameController.text,
      accountNumber: accountNumberController.text,
      holder: holdersNameController.text,
      swiftCode: swiftCodeController.text,
    );
    AppRes.hideCustomLoaderWithBack();
  }
}
