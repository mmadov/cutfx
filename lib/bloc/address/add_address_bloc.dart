import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(AddAddressInitial()) {
    on<AddAddressEvent>((event, emit) {});
    initData();
  }

  AddressData? addressData = Get.arguments;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController mobileTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController localityTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();
  TextEditingController stateTextController = TextEditingController();
  RxInt type = 0.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  void onClickSave() {
    if (nameTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterFullname, false);
      return;
    }
    if (mobileTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterPhoneNumber, false);
      return;
    }
    if (addressTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterAddress, false);
      return;
    }
    if (localityTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterLocalityarea, false);
      return;
    }
    if (cityTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterCity, false);
      return;
    }
    if (pinTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterPinCode, false);
      return;
    }
    if (countryTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterCountry, false);
      return;
    }
    if (stateTextController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterState, false);
      return;
    }
    if (latitude.isEmpty || longitude.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectLocation, false);
      return;
    }
    AppRes.showCustomLoader();

    var futureRest = addressData != null
        ? ApiService().editUserAddress(
            name: nameTextController.text,
            mobile: mobileTextController.text,
            address: addressTextController.text,
            locality: localityTextController.text,
            city: cityTextController.text,
            pin: pinTextController.text,
            country: countryTextController.text,
            state: stateTextController.text,
            type: type.value,
            latitude: latitude.value,
            longitude: longitude.value,
            addressId: addressData?.id?.toInt() ?? -1,
          )
        : ApiService().addUserAddress(
            name: nameTextController.text,
            mobile: mobileTextController.text,
            address: addressTextController.text,
            locality: localityTextController.text,
            city: cityTextController.text,
            pin: pinTextController.text,
            country: countryTextController.text,
            state: stateTextController.text,
            type: type.value,
            latitude: latitude.value,
            longitude: longitude.value,
          );
    futureRest.then(
      (value) {
        if (value.status == true) {
          AppRes.hideCustomLoaderWithBack();
          AppRes.showSnackBar(value.message ?? '', true);
          return;
        }
        AppRes.hideCustomLoader();
        AppRes.showSnackBar(value.message ?? '', false);
      },
    );
  }

  void initData() {
    if (addressData != null) {
      nameTextController.text = addressData?.name ?? '';
      mobileTextController.text = addressData?.mobile ?? '';
      addressTextController.text = addressData?.onlyAddress ?? '';
      localityTextController.text = addressData?.locality ?? '';
      cityTextController.text = addressData?.city ?? '';
      pinTextController.text = addressData?.pin ?? '';
      countryTextController.text = addressData?.country ?? '';
      stateTextController.text = addressData?.state ?? '';
      type.value = addressData?.type?.toInt() ?? 0;
      latitude.value = addressData?.latitude ?? '';
      longitude.value = addressData?.longitude ?? '';
    }
  }
}
