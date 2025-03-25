import 'dart:io';

import 'package:cutfx/bloc/edit/edit_profile_bloc.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(),
      child: Scaffold(
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            EditProfileBloc editProfileBloc = context.read<EditProfileBloc>();
            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCircularInkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image(
                              image: AssetImage(AssetRes.icBack),
                              height: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            AppLocalizations.of(context)!.editProfile,
                            style: kBoldThemeTextStyle,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorRes.themeColor,
                          ),
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Stack(
                              children: [
                                editProfileBloc.imageFile != null
                                    ? Image(
                                        height: double.infinity,
                                        width: double.infinity,
                                        image: FileImage(
                                          editProfileBloc.imageFile ??
                                              File('path'),
                                        ),
                                        fit: BoxFit.cover,
                                        loadingBuilder: loadingImage,
                                        errorBuilder: errorBuilderForImage,
                                      )
                                    : FadeInImage.assetNetwork(
                                        height: double.infinity,
                                        width: double.infinity,
                                        image:
                                            '${ConstRes.itemBaseUrl}${editProfileBloc.imageUrl}',
                                        fit: BoxFit.cover,
                                        placeholder: '1',
                                        placeholderErrorBuilder: loadingImage,
                                        imageErrorBuilder: errorBuilderForImage,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: BgRoundImageWidget(
                                      image: AssetRes.icEdit,
                                      onTap: () {
                                        editProfileBloc
                                            .add(ImageSelectClickEvent());
                                      },
                                      height: 30,
                                      width: 30,
                                      imagePadding: 5,
                                      bgColor: ColorRes.charcoal50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.fullName,
                            controller: editProfileBloc.fullNameTextController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.phoneNumberOptional,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorRes.smokeWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width / 4,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: ColorRes.nero,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                InternationalPhoneNumberInput(
                                  textFieldController:
                                      editProfileBloc.phoneNumberTextController,
                                  onInputChanged: (PhoneNumber number) {
                                    editProfileBloc.salonPhone =
                                        '${number.dialCode} ${number.parseNumber()}';
                                  },
                                  countrySelectorScrollControlled: true,
                                  selectorConfig: const SelectorConfig(
                                    selectorType: PhoneInputSelectorType.DIALOG,
                                    leadingPadding: 7,
                                    trailingSpace: true,
                                    showFlags: true,
                                    useEmoji: true,
                                  ),
                                  selectorTextStyle:
                                      kRegularEmpressTextStyle.copyWith(
                                    color: ColorRes.white,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textStyle: kRegularEmpressTextStyle.copyWith(
                                    color: ColorRes.charcoal50,
                                  ),
                                  cursorColor: ColorRes.themeColor,
                                  keyboardAction: TextInputAction.done,
                                  initialValue: PhoneNumber(
                                    dialCode: editProfileBloc.dailCode,
                                    isoCode: PhoneNumber.getISO2CodeByPrefix(
                                      editProfileBloc.dailCode,
                                    ),
                                  ),
                                  formatInput: true,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: false),
                                  inputDecoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(left: 5),
                                    isCollapsed: false,
                                    counterText: "",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        style: kButtonThemeStyle,
                        onPressed: () {
                          editProfileBloc.add(SubmitEditProfileEvent());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
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
