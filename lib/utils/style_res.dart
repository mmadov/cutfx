import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';

const kSemiBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 23,
);

const kSemiBoldTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 17,
);

const kSemiBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 17,
);
const kMediumWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kMediumTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kMediumThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansMedium,
  fontSize: 20,
);

const kBoldWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansBold,
  fontSize: 23,
);

const kBoldThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansBold,
  fontSize: 20,
);

const kBlackWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansBlack,
  fontSize: 22,
);

const kRegularWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kRegularTextStyle = TextStyle(
  color: ColorRes.neroDark,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kRegularEmpressTextStyle = TextStyle(
  color: ColorRes.empress,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);
const kRegularThemeTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kLightWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansLight,
  fontSize: 14,
);

const kThinWhiteTextStyle = TextStyle(
  color: ColorRes.white,
  fontFamily: AssetRes.fnProductSansThin,
  fontSize: 14,
);

const kBlackButtonTextStyle = TextStyle(
  color: ColorRes.black,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

const kThemeButtonTextStyle = TextStyle(
  color: ColorRes.themeColor,
  fontFamily: AssetRes.fnProductSansRegular,
  fontSize: 16,
);

ButtonStyle kButtonWhiteStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(ColorRes.white),
  shape: WidgetStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: WidgetStateProperty.all(ColorRes.transparent),
);

ButtonStyle kButtonThemeStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(ColorRes.themeColor),
  shape: WidgetStateProperty.all(
    const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  ),
  overlayColor: WidgetStateProperty.all(ColorRes.transparent),
);
