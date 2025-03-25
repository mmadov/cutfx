import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Gallery? gallery = Get.arguments[ConstRes.gallery];
    SalonData? salonData = Get.arguments[ConstRes.salonData];
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorRes.smokeWhite,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  CustomCircularInkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 55,
                      padding: const EdgeInsets.all(5),
                      child: const Image(
                        image: AssetImage(AssetRes.icBack),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: FadeInImage.assetNetwork(
                      image:
                          '${ConstRes.itemBaseUrl}${salonData!.images!.isNotEmpty ? salonData.images?.first.image : ''}',
                      fit: BoxFit.cover,
                      imageErrorBuilder: errorBuilderForImage,
                      placeholderErrorBuilder: loadingImage,
                      placeholder: '1',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        salonData.salonName ?? '',
                        style: kBoldThemeTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        salonData.salonAddress ?? '',
                        style: kLightWhiteTextStyle.copyWith(
                          color: ColorRes.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: DetectableText(
                    text: gallery?.description ?? '',
                    basicStyle: kRegularTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    detectionRegExp: RegExp("#"),
                  ),
                ),
                FadeInImage.assetNetwork(
                  placeholder: '1',
                  image: '${ConstRes.itemBaseUrl}${gallery?.image}',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  placeholderErrorBuilder: loadingImage,
                  imageErrorBuilder: errorBuilderForImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
