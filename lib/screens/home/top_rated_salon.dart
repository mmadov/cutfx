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

class TopRatedSalonsWidget extends StatelessWidget {
  const TopRatedSalonsWidget({
    super.key,
    required this.topRatedSalons,
  });
  final List<SalonData> topRatedSalons;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.topLeft,
      child: ListView.builder(
        itemCount: topRatedSalons.length > 5 ? 5 : topRatedSalons.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          SalonData salonData = topRatedSalons[index];
          return ItemTopRatedSalon(salonData);
        },
      ),
    );
  }
}

class ItemTopRatedSalon extends StatelessWidget {
  final SalonData salonData;

  const ItemTopRatedSalon(
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
                                    Visibility(
                                      visible: salonData.rating != 0,
                                      replacement: const SizedBox(
                                        height: 26,
                                      ),
                                      child: RatingBar(
                                        initialRating:
                                            salonData.rating?.toDouble() ?? 0,
                                        ignoreGestures: true,
                                        ratingWidget: RatingWidget(
                                          full: const Icon(
                                            Icons.star_rounded,
                                            color: ColorRes.sun,
                                          ),
                                          half: const Icon(
                                            Icons.star_rounded,
                                          ),
                                          empty: const Icon(
                                            Icons.star_rounded,
                                            color: ColorRes.darkGray,
                                          ),
                                        ),
                                        onRatingUpdate: (value) {},
                                        itemSize: 22,
                                      ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OpenClosedStatusWidget(
                            salonData: salonData,
                          ),
                          Visibility(
                            visible: salonData.topRated == 1,
                            child: Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorRes.pancho,
                                          ColorRes.fallow
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .topRated
                                          .toUpperCase(),
                                      style: kLightWhiteTextStyle.copyWith(
                                        fontSize: 12,
                                        letterSpacing: 1,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
