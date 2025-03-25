import 'package:cutfx/bloc/search/search_bloc.dart';
import 'package:cutfx/bloc/search/search_event.dart';
import 'package:cutfx/bloc/search/search_state.dart';
import 'package:cutfx/screens/search/search_salon_screen.dart';
import 'package:cutfx/screens/search/search_service_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class SearchScreen extends StatelessWidget {
  final PageController pageController = PageController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SearchBloc(),
        child: Column(
          children: [
            Container(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Image(
                          image: AssetImage(AssetRes.icBack),
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.search,
                            style: kBoldThemeTextStyle,
                          ),
                          const Spacer(),
                          BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              int selectedIndex = 0;
                              if (state is SearchChangeTabState) {
                                selectedIndex = state.selectedIndex;
                              }
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(SearchOnTabClickEvent(0));
                                      pageController.jumpToPage(0);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndex == 0
                                            ? ColorRes.themeColor
                                            : ColorRes.smokeWhite1,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(100),
                                        ),
                                      ),
                                      width: 90,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.service,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: selectedIndex == 0
                                                ? ColorRes.white
                                                : ColorRes.empress,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<SearchBloc>()
                                          .add(SearchOnTabClickEvent(1));
                                      pageController.jumpToPage(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedIndex == 1
                                            ? ColorRes.themeColor
                                            : ColorRes.smokeWhite1,
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          right: Radius.circular(100),
                                        ),
                                      ),
                                      width: 90,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.salon,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: selectedIndex == 1
                                                ? ColorRes.white
                                                : ColorRes.empress,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                // physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SearchServiceScreen(),
                  SearchSalonScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
