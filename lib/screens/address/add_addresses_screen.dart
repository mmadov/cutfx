import 'package:cutfx/bloc/address/add_address_bloc.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/screens/map/map_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressesScreen extends StatelessWidget {
  const AddAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAddressBloc(),
      child: Scaffold(
        body: BlocBuilder<AddAddressBloc, AddAddressState>(
          builder: (context, state) {
            AddAddressBloc addAddressBloc = context.read<AddAddressBloc>();
            return Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.addNewAddress,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextWithTextFieldSmokeWhiteWidget(
                            controller: addAddressBloc.nameTextController,
                            title: AppLocalizations.of(context)!.fullName,
                          ),
                          addSpace(),
                          TextWithTextFieldSmokeWhiteWidget(
                            controller: addAddressBloc.mobileTextController,
                            title: AppLocalizations.of(context)!.phoneNumber,
                            textInputType: TextInputType.phone,
                          ),
                          addSpace(),
                          TextWithTextFieldSmokeWhiteWidget(
                            controller: addAddressBloc.addressTextController,
                            title: AppLocalizations.of(context)!.address,
                          ),
                          addSpace(),
                          TextWithTextFieldSmokeWhiteWidget(
                            controller: addAddressBloc.localityTextController,
                            title: AppLocalizations.of(context)!.localityArea,
                          ),
                          addSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: TextWithTextFieldSmokeWhiteWidget(
                                  controller: addAddressBloc.cityTextController,
                                  title: AppLocalizations.of(context)!.city,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextWithTextFieldSmokeWhiteWidget(
                                  controller: addAddressBloc.pinTextController,
                                  title: AppLocalizations.of(context)!.pinCode,
                                ),
                              ),
                            ],
                          ),
                          addSpace(),
                          Row(
                            children: [
                              Expanded(
                                child: TextWithTextFieldSmokeWhiteWidget(
                                  controller:
                                      addAddressBloc.countryTextController,
                                  title: AppLocalizations.of(context)!.country,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextWithTextFieldSmokeWhiteWidget(
                                  controller:
                                      addAddressBloc.stateTextController,
                                  title: AppLocalizations.of(context)!.state,
                                ),
                              ),
                            ],
                          ),
                          addSpace(),
                          const AddressTypeWidget(),
                          addSpace(),
                          const AttachLocationWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        style: kButtonThemeStyle,
                        onPressed: () {
                          addAddressBloc.onClickSave();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          style: kRegularWhiteTextStyle,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  addSpace() {
    return const SizedBox(
      height: 10,
    );
  }
}

class AddressTypeWidget extends StatelessWidget {
  const AddressTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AddAddressBloc addAddressBloc = context.read<AddAddressBloc>();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.addressType,
            style: kLightWhiteTextStyle.copyWith(
              color: ColorRes.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              CustomCircularInkWell(
                onTap: () {
                  addAddressBloc.type.value = 0;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: addAddressBloc.type.value == 0
                        ? ColorRes.themeColor
                        : ColorRes.smokeWhite,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.home,
                    style: kRegularWhiteTextStyle.copyWith(
                      fontSize: 16,
                      color: addAddressBloc.type.value == 0
                          ? ColorRes.white
                          : ColorRes.nero,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              CustomCircularInkWell(
                onTap: () {
                  addAddressBloc.type.value = 1;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: addAddressBloc.type.value == 1
                        ? ColorRes.themeColor
                        : ColorRes.smokeWhite,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.office,
                    style: kRegularTextStyle.copyWith(
                      fontSize: 16,
                      color: addAddressBloc.type.value == 1
                          ? ColorRes.white
                          : ColorRes.nero,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AttachLocationWidget extends StatelessWidget {
  const AttachLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AddAddressBloc addAddressBloc = context.read<AddAddressBloc>();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.attachLocation,
            style: kLightWhiteTextStyle.copyWith(
              color: ColorRes.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomCircularInkWell(
            onTap: () {
              Get.to(() => const MapScreen(latLng: LatLng(0, 0)))?.then(
                (value) {
                  addAddressBloc.latitude.value =
                      (value as LatLng).latitude.toString();
                  addAddressBloc.longitude.value = (value).longitude.toString();
                },
              );
            },
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: addAddressBloc.latitude.isEmpty ||
                          addAddressBloc.longitude.isEmpty
                      ? ColorRes.smokeWhite
                      : ColorRes.islamicGreen10,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  addAddressBloc.latitude.isEmpty ||
                          addAddressBloc.longitude.isEmpty
                      ? AppLocalizations.of(context)!.clickToFetchLocation
                      : AppLocalizations.of(context)!.locationFetched,
                  style: kLightWhiteTextStyle.copyWith(
                    color: addAddressBloc.latitude.isEmpty ||
                            addAddressBloc.longitude.isEmpty
                        ? ColorRes.empress
                        : ColorRes.islamicGreen,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
