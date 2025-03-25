import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  final Color? textColor;
  final double? textSize;

  const AppLogo({super.key, this.textColor, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.appName.toUpperCase(),
      style: TextStyle(
        color: textColor ?? ColorRes.white,
        fontFamily: AssetRes.fnGilroyBlack,
        fontSize: textSize ?? 22,
      ),
    );
  }
}

class OpenClosedStatusWidget extends StatefulWidget {
  final Color? bgDisable;
  final bool? salonIsOpen;
  final SalonData? salonData;

  const OpenClosedStatusWidget({
    super.key,
    this.bgDisable,
    this.salonIsOpen,
    this.salonData,
  });

  @override
  State<OpenClosedStatusWidget> createState() => _OpenClosedStatusWidgetState();
}

class _OpenClosedStatusWidgetState extends State<OpenClosedStatusWidget> {
  bool isSalonOpen = false;

  void isSalonIsOpen(SalonData? salon) {
    int currentDay = DateTime.now().weekday;

    int todayTime = int.parse(
        '${DateTime.now().hour}${DateTime.now().minute < 10 ? '0${DateTime.now().minute}' : DateTime.now().minute}');
    if (salon?.satSunFrom == null ||
        salon?.satSunTo == null ||
        salon?.monFriFrom == null ||
        salon?.monFriTo == null) {
      isSalonOpen = false;
    }
    if (currentDay > 5) {
      isSalonOpen = int.parse('${salon?.satSunFrom}') < todayTime &&
          int.parse('${salon?.satSunTo}') > todayTime;
    } else {
      isSalonOpen = int.parse('${salon?.monFriFrom}') < todayTime &&
          int.parse('${salon?.monFriTo}') > todayTime;
    }
  }

  @override
  void initState() {
    isSalonIsOpen(widget.salonData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isSalonIsOpen(widget.salonData);
    return Container(
      decoration: BoxDecoration(
        color: isSalonOpen
            ? ColorRes.themeColor
            : widget.bgDisable ?? ColorRes.smokeWhite,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Text(
        (isSalonOpen
                ? AppLocalizations.of(context)!.open
                : AppLocalizations.of(context)!.closed)
            .toUpperCase(),
        style: kLightWhiteTextStyle.copyWith(
          color: isSalonOpen ? ColorRes.white : ColorRes.empress,
          fontSize: 12,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class TitleWithSeeAllWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const TitleWithSeeAllWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: kSemiBoldTextStyle,
          ),
          const Spacer(),
          CustomCircularInkWell(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: kRegularEmpressTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCircularInkWell extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;

  const CustomCircularInkWell({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(ColorRes.transparent),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: child,
    );
  }
}

class ToolBarWidget extends StatelessWidget {
  final String title;
  final Widget? child;

  const ToolBarWidget({
    super.key,
    required this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.smokeWhite,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCircularInkWell(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Image(
                  image: AssetImage(AssetRes.icBack),
                  height: 30,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    title,
                    style: kBoldThemeTextStyle,
                  ),
                ),
                const Spacer(),
                child ?? const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget loadingImage(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const LoadingImage();
}

Widget loadingImageTransParent(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const SizedBox();
}

Widget errorBuilderForImage(context, error, stackTrace) {
  return const ImageNotFound();
}

class ImageNotFound extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;

  const ImageNotFound({
    super.key,
    this.color,
    this.tintcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: Center(
        child: Text(
          ':-('.toUpperCase(),
          style: kBoldThemeTextStyle.copyWith(
            color: tintcolor ?? ColorRes.smokeWhite1,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class ImageNotFoundOval extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;
  final double? fontSize;

  const ImageNotFoundOval({
    super.key,
    this.color,
    this.tintcolor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: color ?? ColorRes.smokeWhite,
        child: Center(
          child: Text(
            ':-('.toUpperCase(),
            style: kBoldThemeTextStyle.copyWith(
              color: tintcolor ?? ColorRes.smokeWhite1,
              fontSize: fontSize ?? 50,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingImage extends StatelessWidget {
  final Color? color;

  const LoadingImage({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: Center(
        child: Text(
          '...'.toUpperCase(),
          style: kBoldThemeTextStyle.copyWith(
            color: ColorRes.smokeWhite1,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(AssetRes.icNoData),
            width: 275,
          ),
        )
      ],
    );
  }
}

class LoadingData extends StatelessWidget {
  final Color? color;

  const LoadingData({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorRes.themeColor,
        ),
      ),
    );
  }
}

class CustomMenuWidget extends StatefulWidget {
  const CustomMenuWidget({super.key, required this.onMenuClick});

  final Function(int position) onMenuClick;

  @override
  State<CustomMenuWidget> createState() => _CustomMenuWidgetState();
}

class _CustomMenuWidgetState extends State<CustomMenuWidget> {
  final MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        MenuWidget(
          menuController: menuController,
          onMenuClick: widget.onMenuClick,
          index: 0,
          title: AppLocalizations.of(context)!.edit,
        ),
        MenuWidget(
          menuController: menuController,
          onMenuClick: widget.onMenuClick,
          index: 1,
          title: AppLocalizations.of(context)!.delete,
          isLast: true,
        ),
      ],
      controller: menuController,
      builder: (context, controller, child) {
        return BgRoundImageWidget(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open(position: const Offset(-65, 20));
            }
          },
          image: AssetRes.icMenu2,
          imagePadding: 5,
          bgColor: ColorRes.smokeWhite1.withOpacity(.5),
          height: 32,
          width: 32,
        );
      },
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.menuController,
    required this.onMenuClick,
    required this.index,
    required this.title,
    this.isLast = false,
  });

  final MenuController menuController;
  final Function(int position) onMenuClick;
  final int index;
  final bool isLast;

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast ? ColorRes.transparent : ColorRes.smokeWhite,
            ),
          ),
        ),
        padding: EdgeInsets.only(
            bottom: isLast ? 0 : 5, top: isLast ? 5 : 0, left: 20, right: 20),
        child: Center(
          child: Text(
            title,
            style: kMediumTextStyle.copyWith(
              fontSize: 14,
              color: ColorRes.mortar,
            ),
          ),
        ),
      ),
      onTap: () {
        onMenuClick(index);
        menuController.close();
      },
    );
  }
}

class ItemOptionsWidget extends StatelessWidget {
  const ItemOptionsWidget({
    super.key,
    required this.index,
    required this.title,
    required this.isSelected,
    required this.onClick,
  });

  final int index;
  final String title;
  final bool isSelected;
  final Function(int position) onClick;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        onClick(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? ColorRes.themeColor : ColorRes.smokeWhite,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 8,
        ),
        child: Text(
          title,
          style: kRegularWhiteTextStyle.copyWith(
            fontSize: 16,
            color: isSelected ? ColorRes.white : ColorRes.nero,
          ),
        ),
      ),
    );
  }
}
