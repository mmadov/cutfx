import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/categories/salon_by_cat_screen.dart';
import 'package:cutfx/screens/service/service_detail_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class CategoriesWithSalonsWidget extends StatelessWidget {
  const CategoriesWithSalonsWidget({
    super.key,
    required this.categoriesWithServices,
  });
  final List<CategoriesWithService> categoriesWithServices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categoriesWithServices.length,
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        CategoriesWithService categoriesWithService =
            categoriesWithServices[index];
        return Container(
          color: ColorRes.smokeWhite,
          padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    categoriesWithService.title?.toUpperCase() ?? '',
                    style: kThinWhiteTextStyle.copyWith(
                      color: ColorRes.themeColor,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  CustomCircularInkWell(
                    onTap: () {
                      Get.to(
                        () => const CategoryDetailScreen(),
                        arguments:
                            Categories.fromJson(categoriesWithService.toJson()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.seeAll,
                      style: kRegularEmpressTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 225,
                child: ListView.builder(
                  itemCount: (categoriesWithService.services?.length ?? 0) >= 4
                      ? 4
                      : categoriesWithService.services?.length,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    Services? service = categoriesWithService.services?[index];
                    return ItemCategoriesWithSalons(
                      services: service,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemCategoriesWithSalons extends StatelessWidget {
  const ItemCategoriesWithSalons({
    super.key,
    required this.services,
  });
  final Services? services;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(
          () => const ServiceDetailScreen(),
          arguments: services?.id?.toInt() ?? -1,
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Column(
              children: [
                Expanded(
                  child: FadeInImage.assetNetwork(
                    width: double.infinity,
                    image:
                        '${ConstRes.itemBaseUrl}${services!.images!.isNotEmpty ? services?.images![0].image : ''}',
                    fit: BoxFit.cover,
                    placeholder: '1',
                    placeholderErrorBuilder: loadingImage,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const ImageNotFound(
                        color: ColorRes.smokeWhite2,
                        tintcolor: ColorRes.smokeWhite1,
                      );
                    },
                  ),
                ),
                Container(
                  color: ColorRes.white,
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    right: 10,
                    left: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        services?.title ?? '',
                        style: kBoldWhiteTextStyle.copyWith(
                          color: ColorRes.nero,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            '${AppRes.currency}${services?.price ?? ''}',
                            style: kBoldThemeTextStyle.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '-',
                              style: kThinWhiteTextStyle.copyWith(
                                color: ColorRes.mortar,
                              ),
                            ),
                          ),
                          Text(
                            '${AppRes.convertTimeForService(services?.serviceTime?.toInt() ?? 0)} ',
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.mortar,
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
