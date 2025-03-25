import 'package:cutfx/bloc/main/main_screen_bloc.dart';
import 'package:cutfx/bloc/main/main_screen_state.dart';
import 'package:cutfx/screens/booking/booking_screen.dart';
import 'package:cutfx/screens/drawer/drawer_screen.dart';
import 'package:cutfx/screens/fav/favourite_screen.dart';
import 'package:cutfx/screens/home/home_screen.dart';
import 'package:cutfx/screens/message/message_screen.dart';
import 'package:cutfx/screens/profile/profile_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final GlobalKey<ScaffoldState> _globalKey =
      GlobalKey(debugLabel: 'mainScreen');

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: 0, keepPage: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BlocProvider(
      create: (context) => MainScreenBloc(),
      child: Scaffold(
        key: _globalKey,
        drawer: const DrawerScreen(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomeScreen(
                    onMenuClick: _openDrawer,
                  ),
                  FavouriteScreen(
                    onMenuClick: _openDrawer,
                  ),
                  MyBookingScreen(
                    onMenuClick: _openDrawer,
                  ),
                  MessageScreen(
                    onMenuClick: _openDrawer,
                  ),
                  ProfileScreen(
                    onMenuClick: _openDrawer,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ],
                color: ColorRes.white,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SafeArea(
                top: false,
                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                    int selectedIndex = 0;
                    MainScreenBloc mainScreenBloc =
                        context.read<MainScreenBloc>();
                    if (state is MenuChangeMainScreenState) {
                      selectedIndex = state.selectedIndex;
                      pageController.jumpToPage(selectedIndex);
                    }
                    return Row(
                      children: [
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icHome,
                          imageSize: 22,
                          menuIsSelected: selectedIndex == 0,
                          title: AppLocalizations.of(context)!.home,
                          nonSelectedImageSize: 24,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(0);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icFav,
                          imageSize: 22,
                          menuIsSelected: selectedIndex == 1,
                          title: AppLocalizations.of(context)!.favourite,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(1);
                          },
                          nonSelectedImageSize: 24,
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icBooking,
                          imageSize: 26,
                          menuIsSelected: selectedIndex == 2,
                          title: AppLocalizations.of(context)!.myBooking,
                          nonSelectedImageSize: 30,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(2);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icChat,
                          imageSize: 20,
                          menuIsSelected: selectedIndex == 3,
                          title: AppLocalizations.of(context)!.messages,
                          nonSelectedImageSize: 20,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(3);
                          },
                        ),
                        const Spacer(),
                        BottomMenuItem(
                          image: AssetRes.icProfile,
                          imageSize: 18,
                          menuIsSelected: selectedIndex == 4,
                          title: AppLocalizations.of(context)!.profile,
                          nonSelectedImageSize: 18,
                          onTap: () {
                            mainScreenBloc.onMenuClickEvent(4);
                          },
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openDrawer() {
    _globalKey.currentState?.openDrawer();
  }
}

class BottomMenuItem extends StatelessWidget {
  final String image;
  final double imageSize;
  final String title;
  final bool menuIsSelected;
  final double? nonSelectedImageSize;
  final Function()? onTap;

  const BottomMenuItem({
    super.key,
    required this.image,
    required this.imageSize,
    required this.title,
    required this.menuIsSelected,
    this.nonSelectedImageSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: menuIsSelected ? ColorRes.lavender : ColorRes.transparent,
        ),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image(
              image: AssetImage(image),
              height: menuIsSelected ? imageSize : nonSelectedImageSize,
              color: menuIsSelected ? ColorRes.themeColor : ColorRes.darkGray,
            ),
            Visibility(
              visible: menuIsSelected,
              child: const SizedBox(
                width: 10,
              ),
            ),
            Visibility(
              visible: menuIsSelected,
              child: Text(
                title,
                style: kRegularTextStyle.copyWith(
                  color: ColorRes.themeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BgRoundImageWidget extends StatelessWidget {
  final String image;
  final double? imagePadding;
  final double? height;
  final double? width;
  final Color? imageColor;
  final Color? bgColor;
  final Function()? onTap;

  const BgRoundImageWidget({
    super.key,
    required this.image,
    this.imagePadding,
    this.onTap,
    this.imageColor,
    this.bgColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 40,
        decoration: BoxDecoration(
          color: bgColor ?? ColorRes.themeColor10,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        padding: EdgeInsets.all(imagePadding ?? 0),
        child: Image(
          image: AssetImage(image),
          color: imageColor,
        ),
      ),
    );
  }
}
