import 'package:cutfx/bloc/searchservice/search_service_bloc.dart';
import 'package:cutfx/model/service/services.dart';
import 'package:cutfx/model/user/salon.dart' as salon;
import 'package:cutfx/screens/fav/service_screen.dart';
import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/route_manager.dart';

class SearchServiceScreen extends StatefulWidget {
  const SearchServiceScreen({super.key});

  @override
  State<SearchServiceScreen> createState() => _SearchServiceScreenState();
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {
  bool searchIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchServiceBloc(),
      child: BlocBuilder<SearchServiceBloc, SearchServiceState>(
        builder: (context, state) {
          SearchServiceBloc searchServiceBloc =
              context.read<SearchServiceBloc>();
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
                        focusNode: searchServiceBloc.focusNode,
                        controller: searchServiceBloc.searchController,
                        textCapitalization: TextCapitalization.sentences,
                        style: kRegularTextStyle.copyWith(
                          color: ColorRes.charcoal50,
                        ),
                        onTapOutside: (event) {
                          searchServiceBloc.onTaOutsideOfTextField();
                        },
                      ),
                    ),
                    CustomCircularInkWell(
                      onTap: () {
                        Get.bottomSheet(
                          FilterBottomSheet(
                              catId: searchServiceBloc.catId ?? ''),
                          isScrollControlled: true,
                          ignoreSafeArea: false,
                        ).then((value) {
                          if (value != null && value is String) {
                            searchServiceBloc.setCatId(value);
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
              state is SearchServiceInitial
                  ? const Expanded(
                      child: LoadingData(
                        color: ColorRes.white,
                      ),
                    )
                  : Expanded(
                      child: searchServiceBloc.services.isEmpty
                          ? const DataNotFound()
                          : SafeArea(
                              top: false,
                              child: SingleChildScrollView(
                                controller: searchServiceBloc.scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: searchServiceBloc
                                                .recentSearch.isNotEmpty &&
                                            searchServiceBloc
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
                                                    searchServiceBloc
                                                        .clearAll();
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
                                              itemCount: searchServiceBloc
                                                          .recentSearch.length >
                                                      3
                                                  ? 3
                                                  : searchServiceBloc
                                                      .recentSearch.length,
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              itemBuilder: (context, index) {
                                                String data = searchServiceBloc
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
                                                            searchServiceBloc
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
                                        visible: searchServiceBloc
                                            .searchController.text.isEmpty,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .suggestions,
                                          style: kSemiBoldTextStyle,
                                        ),
                                      ),
                                      ListView.builder(
                                        itemCount:
                                            searchServiceBloc.services.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        itemBuilder: (context, index) {
                                          ServiceData serviceData =
                                              searchServiceBloc.services[index];
                                          return ItemService(
                                            services: salon.Services.fromJson(
                                              serviceData.toJson(),
                                            ),
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
}

class ItemPopularSearch extends StatelessWidget {
  final String title;

  const ItemPopularSearch({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorRes.lavender,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      child: Text(
        title,
        style: kSemiBoldThemeTextStyle.copyWith(
          fontSize: 16,
        ),
      ),
    );
  }
}
