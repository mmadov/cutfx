import 'package:cutfx/bloc/manageaddress/manage_address_bloc.dart';
import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/screens/address/add_addresses_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../profile/delete_account_bottom.dart';

class ManageMyAddressesScreen extends StatelessWidget {
  const ManageMyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageAddressBloc(),
      child: BlocBuilder<ManageAddressBloc, ManageAddressState>(
        builder: (context, state) {
          ManageAddressBloc manageAddressBloc =
              context.read<ManageAddressBloc>();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => const AddAddressesScreen())?.then(
                  (value) {
                    manageAddressBloc.fetchMyAddress();
                  },
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset(
                AssetRes.icPlus,
                height: 35,
                width: 35,
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.myAddresses,
                ),
                Visibility(
                  visible: manageAddressBloc.isEnabledSelect,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Text(
                      AppLocalizations.of(context)!.clickOnAnyAddressToSelect,
                      style: kSemiBoldThemeTextStyle.copyWith(
                        color: ColorRes.empress,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: manageAddressBloc.isLoading
                      ? const LoadingData()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemBuilder: (context, index) {
                            AddressData addressData =
                                manageAddressBloc.addresses[index];
                            return CustomCircularInkWell(
                              onTap: () {
                                if (manageAddressBloc.isEnabledSelect) {
                                  Get.back(result: addressData);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 5,
                                ),
                                color: ColorRes.smokeWhite2,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          addressData.name ?? '',
                                          style: kMediumThemeTextStyle.copyWith(
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorRes.lavender,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: ColorRes.themeColor,
                                              width: .75,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            AppRes
                                                .getAddressTypeInStringFromNumber(
                                              addressData.type?.toInt() ?? 0,
                                            ),
                                            style:
                                                kMediumThemeTextStyle.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        manageAddressBloc.isEnabledSelect
                                            ? const SizedBox()
                                            : CustomMenuWidget(
                                                onMenuClick: (position) {
                                                  if (position == 0) {
                                                    ///Edit
                                                    Get.to(
                                                      () =>
                                                          const AddAddressesScreen(),
                                                      arguments: addressData,
                                                    )?.then(
                                                      (value) {
                                                        manageAddressBloc
                                                            .fetchMyAddress();
                                                      },
                                                    );
                                                  } else if (position == 1) {
                                                    ///Delete
                                                    Get.bottomSheet(
                                                      ConfirmationBottomSheet(
                                                        title:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .deleteAddress,
                                                        description: addressData
                                                                .address ??
                                                            '',
                                                        buttonText:
                                                            AppLocalizations.of(
                                                                    Get.context!)!
                                                                .delete,
                                                        onButtonClick:
                                                            () async {
                                                          Get.back();
                                                          manageAddressBloc
                                                              .deleteAddress(
                                                                  addressData);
                                                        },
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                      ],
                                    ),
                                    Text(
                                      addressData.mobile ?? '',
                                      style: kMediumThemeTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        addressData.address ?? '',
                                        style: kLightWhiteTextStyle.copyWith(
                                          color: ColorRes.empress,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: manageAddressBloc.addresses.length,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
