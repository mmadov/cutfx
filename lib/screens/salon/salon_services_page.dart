import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/booking/confirm_booking.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/service/service_detail_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class SalonServicesPage extends StatefulWidget {
  const SalonServicesPage({super.key});

  @override
  State<SalonServicesPage> createState() => _SalonServicesPageState();
}

class _SalonServicesPageState extends State<SalonServicesPage> {
  @override
  Widget build(BuildContext context) {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: salonDetailsBloc.categories.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              Categories category = salonDetailsBloc.categories[index];
              return ItemSalonDetailsService(
                categories: category,
                onUpdate: () {
                  setState(() {});
                },
              );
            },
          ),
        ),
        Visibility(
          visible: salonDetailsBloc.totalRates() != 0,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppRes.currency}${salonDetailsBloc.totalRates()}',
                        style: kBoldThemeTextStyle,
                      ),
                      Text(
                        AppLocalizations.of(context)!.subTotal,
                        style: kLightWhiteTextStyle.copyWith(
                          color: ColorRes.empress,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: TextButton(
                      style: kButtonThemeStyle,
                      onPressed: () {
                        if (ConstRes.userIdValue == -1) {
                          Get.to(() => const LoginOptionScreen());
                          return;
                        }
                        Get.to(
                          () => const ConfirmBookingScreen(),
                          arguments: {
                            ConstRes.salonData: salonDetailsBloc.salonData,
                            ConstRes.services:
                                salonDetailsBloc.selectedServices,
                          },
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.placeBooking,
                        style: kRegularWhiteTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemSalonDetailsService extends StatelessWidget {
  final Categories categories;
  final Function()? onUpdate;

  const ItemSalonDetailsService({
    super.key,
    required this.categories,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            categories.title?.toUpperCase() ?? '',
            style: kLightWhiteTextStyle.copyWith(
              color: ColorRes.themeColor,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: categories.services?.length ?? 0,
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              Services? service = categories.services?[index];
              return ItemServiceTYpeWidget(
                service: service,
                onUpdate: onUpdate,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemServiceTYpeWidget extends StatefulWidget {
  const ItemServiceTYpeWidget({
    super.key,
    this.service,
    this.onUpdate,
  });
  final Services? service;
  final Function()? onUpdate;

  @override
  State<ItemServiceTYpeWidget> createState() => _ItemServiceTYpeWidgetState();
}

class _ItemServiceTYpeWidgetState extends State<ItemServiceTYpeWidget> {
  bool isAdded = false;

  @override
  void initState() {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    isAdded = salonDetailsBloc.isSelected(widget.service?.id?.toInt() ?? -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(
          () => const ServiceDetailScreen(),
          arguments: widget.service?.id?.toInt() ?? -1,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: ColorRes.smokeWhite2,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Row(
            children: [
              SizedBox(
                width: 130,
                height: 110,
                child: FadeInImage.assetNetwork(
                  placeholder: '1',
                  image:
                      '${ConstRes.itemBaseUrl}${widget.service!.images!.isNotEmpty ? widget.service?.images?.first.image : ''}',
                  fit: BoxFit.cover,
                  imageErrorBuilder: errorBuilderForImage,
                  placeholderErrorBuilder: loadingImage,
                ),
              ),
              Expanded(
                child: Container(
                  color: isAdded ? ColorRes.lavender : ColorRes.smokeWhite2,
                  padding: const EdgeInsets.only(
                    bottom: 5,
                    right: 10,
                    left: 10,
                  ),
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.service?.title ?? '',
                        style: kSemiBoldTextStyle.copyWith(
                          color: ColorRes.nero,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${AppRes.currency}${(widget.service?.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(widget.service?.price?.toInt() ?? 0, widget.service?.discount?.toInt() ?? 0).toInt()}',
                                    style: kBoldThemeTextStyle.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      '-',
                                      style: kThinWhiteTextStyle.copyWith(
                                        color: ColorRes.mortar,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppRes.convertTimeForService(
                                        widget.service?.serviceTime?.toInt() ??
                                            0),
                                    style: kThinWhiteTextStyle.copyWith(
                                      color: ColorRes.mortar,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppRes.getGenderTypeInStringFromNumber(context,
                                    widget.service?.gender?.toInt() ?? 0),
                                style: kLightWhiteTextStyle.copyWith(
                                  color: ColorRes.empress,
                                  fontSize: 12,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          PlusMinusImageWidget(
                            onTapChange: (isAdded) {
                              this.isAdded = isAdded;
                              setState(() {});
                              widget.onUpdate?.call();
                            },
                            services: widget.service,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlusMinusImageWidget extends StatefulWidget {
  final Function(bool isAdded)? onTapChange;
  final Services? services;

  const PlusMinusImageWidget({
    super.key,
    this.onTapChange,
    this.services,
  });

  @override
  State<PlusMinusImageWidget> createState() => _PlusMinusImageWidgetState();
}

class _PlusMinusImageWidgetState extends State<PlusMinusImageWidget> {
  bool serviceIsAdded = false;
  late SalonDetailsBloc salonDetailsBloc;

  @override
  void initState() {
    salonDetailsBloc = context.read<SalonDetailsBloc>();
    serviceIsAdded =
        salonDetailsBloc.isSelected(widget.services?.id?.toInt() ?? -1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        if (serviceIsAdded) {
          salonDetailsBloc.selectedServices.remove(widget.services);
        } else {
          if (widget.services != null) {
            salonDetailsBloc.selectedServices.add(widget.services!);
          }
        }
        serviceIsAdded = !serviceIsAdded;
        widget.onTapChange?.call(serviceIsAdded);
        setState(() {});
      },
      child: BgRoundImageWidget(
        image: serviceIsAdded ? AssetRes.icMinus : AssetRes.icPlus,
        imagePadding: serviceIsAdded ? 11 : 7,
        bgColor: serviceIsAdded ? ColorRes.monaLisa : ColorRes.themeColor,
        height: 35,
        width: 35,
      ),
    );
  }
}
