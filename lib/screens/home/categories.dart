import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/screens/categories/salon_by_cat_screen.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesGridWidget extends StatelessWidget {
  final List<Categories> categories;

  const CategoriesGridWidget({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.2 / 1),
        itemCount: categories.length >= 4 ? 8 : categories.length,
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          Categories category = categories[index];
          return CustomCircularInkWell(
            onTap: () {
              Get.to(
                () => const CategoryDetailScreen(),
                arguments: category,
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                color: ColorRes.lavender,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: const EdgeInsets.all(2.5),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: FadeInImage.assetNetwork(
                          image: '${ConstRes.itemBaseUrl}${category.icon}',
                          imageErrorBuilder: errorBuilderForImage,
                          placeholderErrorBuilder: loadingImageTransParent,
                          placeholder: '1',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      category.title ?? '',
                      style: kRegularThemeTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
