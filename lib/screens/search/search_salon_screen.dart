import 'package:cutfx/bloc/searchsalon/search_salon_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/fav/salon_screen.dart';
import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SearchSalonScreen extends StatefulWidget {
  const SearchSalonScreen({super.key});

  @override
  State<SearchSalonScreen> createState() => _SearchSalonScreenState();
}

class _SearchSalonScreenState extends State<SearchSalonScreen> {
  bool searchIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchSalonBloc(),
      child: BlocBuilder<SearchSalonBloc, SearchSalonState>(
        builder: (context, state) {
          SearchSalonBloc searchSalonBloc = context.read<SearchSalonBloc>();
          return Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorRes.smokeWhite,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: kRegularTextStyle.copyWith(
                            color: ColorRes.darkGray,
                          ),
                        ),
                        focusNode: searchSalonBloc.focusNode,
                        controller: searchSalonBloc.searchController,
                        textCapitalization: TextCapitalization.sentences,
                        style: kRegularTextStyle.copyWith(
                          color: ColorRes.charcoal50,
                        ),
                        onTapOutside: (event) {
                          searchSalonBloc.onTaOutsideOfTextField();
                        },
                      ),
                    ),
                    CustomCircularInkWell(
                      onTap: () {
                        Get.bottomSheet(
                          FilterBottomSheet(
                            catId: searchSalonBloc.catId ?? '',
                          ),
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                        ).then((value) {
                          if (value != null && value is String) {
                            searchSalonBloc.setCatId(value);
                          }
                        });
                      },
                      child: const Image(
                        image: AssetImage(AssetRes.icFilter),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state is SearchSalonInitial
                    ? const LoadingData()
                    : SafeArea(
                        top: false,
                        child: searchSalonBloc.salons.isEmpty
                            ? const DataNotFound(
                                color: ColorRes.white,
                              )
                            : SingleChildScrollView(
                                controller: searchSalonBloc.scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: searchSalonBloc
                                                .recentSearch.isNotEmpty &&
                                            searchSalonBloc
                                                .searchController.text.isEmpty,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .recent,
                                                  style: kRegularTextStyle
                                                      .copyWith(),
                                                ),
                                                const Spacer(),
                                                CustomCircularInkWell(
                                                  onTap: () {
                                                    searchSalonBloc.clearAll();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .clearAll,
                                                    style:
                                                        kRegularThemeTextStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: searchSalonBloc
                                                          .recentSearch.length >
                                                      3
                                                  ? 3
                                                  : searchSalonBloc
                                                      .recentSearch.length,
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              itemBuilder: (context, index) {
                                                String data = searchSalonBloc
                                                    .recentSearch[index];
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          data,
                                                          style:
                                                              kRegularThemeTextStyle
                                                                  .copyWith(
                                                            color: ColorRes
                                                                .empress,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        CustomCircularInkWell(
                                                          onTap: () {
                                                            searchSalonBloc
                                                                .deleteRecentSearch(
                                                                    data);
                                                          },
                                                          child: const Icon(
                                                            Icons.close_rounded,
                                                            size: 24,
                                                            color: ColorRes
                                                                .empress,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      color: ColorRes.darkGray,
                                                      height: 0.2,
                                                      width: double.infinity,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: searchSalonBloc
                                            .searchController.text.isEmpty,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .suggestions,
                                          style: kSemiBoldTextStyle,
                                        ),
                                      ),
                                      ListView.builder(
                                        itemCount:
                                            searchSalonBloc.salons.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        itemBuilder: (context, index) {
                                          SalonData salonData =
                                              searchSalonBloc.salons[index];
                                          return ItemSalon(
                                            salonData: salonData,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
