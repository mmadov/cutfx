import 'package:cutfx/bloc/fav/favourite_bloc.dart';
import 'package:cutfx/bloc/fav/favourite_state.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/service/service_detail_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return state is FavouriteDataFound
            ? (state.favouriteData.data != null &&
                    state.favouriteData.data!.services!.isNotEmpty
                ? ListView.builder(
                    itemCount: state.favouriteData.data?.services?.length ?? 0,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    itemBuilder: (context, index) {
                      Services? services =
                          state.favouriteData.data?.services?[index];
                      return ItemService(
                        services: services,
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

class ItemService extends StatelessWidget {
  final Services? services;

  const ItemService({
    super.key,
    this.services,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(() => const ServiceDetailScreen(),
            arguments: services?.id?.toInt() ?? -1);
      },
      child: AspectRatio(
        aspectRatio: 1 / .35,
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
                            '${ConstRes.itemBaseUrl}${services!.images!.isNotEmpty ? services?.images?.first.image : ''}',
                        fit: BoxFit.cover,
                        imageErrorBuilder: errorBuilderForImage,
                        placeholderErrorBuilder: loadingImageTransParent,
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
                      bottom: 10,
                      right: 10,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          services?.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kSemiBoldTextStyle.copyWith(
                            color: ColorRes.nero,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'By ${services?.salonData?.salonName ?? ''}',
                          style: kThinWhiteTextStyle.copyWith(
                            color: ColorRes.empress,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${AppRes.currency}${(services?.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(services?.price?.toInt() ?? 0, services?.discount?.toInt() ?? 0).toInt()}',
                              style: kBoldThemeTextStyle.copyWith(
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '-',
                                style: kThinWhiteTextStyle.copyWith(
                                  color: ColorRes.mortar,
                                ),
                              ),
                            ),
                            Text(
                              AppRes.convertTimeForService(
                                  services?.serviceTime?.toInt() ?? 0),
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
