import 'dart:ui';

import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/salon/salon_details_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class NewSalonsWidget extends StatelessWidget {
  const NewSalonsWidget({
    super.key,
    required this.newSalons,
  });

  final List<SalonData> newSalons;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.topLeft,
      child: ListView.builder(
        itemCount: newSalons.length > 5 ? 5 : newSalons.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          SalonData salonData = newSalons[index];
          return ItemNewSalon(salonData);
        },
      ),
    );
  }
}

class ItemNewSalon extends StatelessWidget {
  final SalonData salonData;

  const ItemNewSalon(
    this.salonData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CustomCircularInkWell(
        onTap: () {
          Get.to(() => const SalonDetailsScreen(), arguments: salonData.id);
        },
        child: AspectRatio(
          aspectRatio: 1 / 1.2,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: [
                FadeInImage.assetNetwork(
                  image:
                      '${ConstRes.itemBaseUrl}${(salonData.images != null && salonData.images!.isNotEmpty) ? salonData.images![0].image : ''}',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageErrorBuilder: errorBuilderForImage,
                  placeholderErrorBuilder: loadingImage,
                  placeholder: '1',
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                                tileMode: TileMode.mirror,
                              ),
                              child: Container(
                                width: double.infinity,
                                color: ColorRes.black.withOpacity(.4),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      salonData.salonName ?? '',
                                      style: kSemiBoldWhiteTextStyle.copyWith(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      salonData.salonAddress ?? '',
                                      style: kThinWhiteTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Text(
                                        '${AppRes.calculateDistance(double.parse(salonData.salonLat ?? '0'), double.parse(salonData.salonLong ?? '0'))} Km Away ',
                                        style: kLightWhiteTextStyle.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            "NEW",
                            style: kSemiBoldWhiteTextStyle.copyWith(
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
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
    );
  }
}
