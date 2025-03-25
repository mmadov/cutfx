import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrCodeBottomSheet extends StatelessWidget {
  const MyQrCodeBottomSheet({super.key, required this.bookingId});
  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.showThisQRAtSalon,
                  style: kBoldThemeTextStyle,
                ),
                const Spacer(),
                const CloseButtonWidget(),
              ],
            ),
            Text(
              AppLocalizations.of(context)!
                  .offerThisQRAtSalonShopTheyWillScanItAndWillHaveAllTheDetails,
              style: kLightWhiteTextStyle.copyWith(
                color: ColorRes.subTitleText,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorRes.smokeWhite,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: QrImageView(
                      data: bookingId,
                      errorCorrectionLevel: 2,
                      eyeStyle: const QrEyeStyle(
                        color: ColorRes.themeColor,
                        eyeShape: QrEyeShape.square,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        color: ColorRes.themeColor,
                        dataModuleShape: QrDataModuleShape.square,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
