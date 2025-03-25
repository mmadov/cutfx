import 'package:cutfx/bloc/fav/favourite_bloc.dart';
import 'package:cutfx/bloc/fav/favourite_state.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/salon/salon_details_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SalonScreen extends StatelessWidget {
  const SalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return state is FavouriteDataFound
            ? (state.favouriteData.data != null &&
                    state.favouriteData.data!.salons!.isNotEmpty
                ? ListView.builder(
                    itemCount: state.favouriteData.data?.salons?.length ?? 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    itemBuilder: (context, index) {
                      SalonData? salonData =
                          state.favouriteData.data?.salons?[index];
                      return ItemSalon(
                        salonData: salonData,
                      );
                    },
                  )
                : const Center(child: DataNotFound()))
            : const LoadingData(
                color: ColorRes.white,
              );
      },
    );
  }
}

class ItemSalon extends StatelessWidget {
  final SalonData? salonData;

  const ItemSalon({
    super.key,
    this.salonData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(
          () => const SalonDetailsScreen(),
          arguments: salonData?.id?.toInt(),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / .4,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            color: ColorRes.white,
            boxShadow: [
              BoxShadow(
                color: ColorRes.smokeWhite1,
                offset: Offset(1, 1),
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        width: double.infinity,
                        height: double.infinity,
                        image:
                            '${ConstRes.itemBaseUrl}${salonData!.images!.isNotEmpty ? (salonData?.images?[0].image ?? '') : ''}',
                        fit: BoxFit.cover,
                        imageErrorBuilder: errorBuilderForImage,
                        placeholderErrorBuilder: loadingImage,
                        placeholder: '1',
                      ),
                      // const Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      //   child: Icon(
                      //     Icons.favorite_rounded,
                      //     color: ColorRes.bitterSweet,
                      //     size: 28,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: ColorRes.white,
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${salonData?.getCatInString()}',
                          style: kRegularTextStyle.copyWith(
                            color: ColorRes.themeColor,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          salonData?.salonName ?? '',
                          style: kSemiBoldTextStyle.copyWith(
                            color: ColorRes.nero,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          salonData?.salonAddress ?? '',
                          style: kThinWhiteTextStyle.copyWith(
                            color: ColorRes.empress,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: true,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: ColorRes.pumpkin15,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      salonData?.rating?.toStringAsFixed(1) ??
                                          '',
                                      style: kRegularTextStyle.copyWith(
                                        color: ColorRes.pumpkin,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: ColorRes.pumpkin,
                                      size: 19,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${AppRes.calculateDistance(double.parse(salonData?.salonLat ?? '0'), double.parse(salonData?.salonLong ?? '0'))} km',
                              style: kThinWhiteTextStyle.copyWith(
                                color: ColorRes.mortar,
                              ),
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
      ),
    );
  }
}
