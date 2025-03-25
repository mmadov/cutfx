import 'package:cutfx/bloc/service/service_details_bloc.dart';
import 'package:cutfx/model/service/services.dart';
import 'package:cutfx/model/service/services_details.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/booking/confirm_booking.dart';
import 'package:cutfx/screens/fav/salon_screen.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  ScrollController scrollController = ScrollController();
  bool toolbarIsExpand = true;
  bool lastToolbarIsExpand = true;

  @override
  void initState() {
    scrollController.addListener(() {
      toolbarIsExpand = !(scrollController.offset >=
          scrollController.position.maxScrollExtent - 120);
      if (lastToolbarIsExpand != toolbarIsExpand) {
        lastToolbarIsExpand = toolbarIsExpand;
        if (!lastToolbarIsExpand) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceDetailsBloc(),
      child: Scaffold(
        body: BlocBuilder<ServiceDetailsBloc, ServiceDetailsState>(
          builder: (context, state) {
            ServiceDetails? serviceDetails =
                state is ServiceDetailsDataFoundState
                    ? state.serviceDetails
                    : null;
            ServiceDetailsBloc serviceDetailsBloc =
                context.read<ServiceDetailsBloc>();
            return NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  TopBarOfServiceDetails(
                    toolbarIsExpand: toolbarIsExpand,
                    serviceDetails: serviceDetails,
                    userData: serviceDetailsBloc.userData,
                  ),
                ];
              },
              physics: const NeverScrollableScrollPhysics(),
              body: state is ServiceDetailsDataFoundState
                  ? SafeArea(
                      top: false,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin: EdgeInsets.only(
                          top: toolbarIsExpand
                              ? 0
                              : MediaQuery.of(context).viewPadding.top +
                                  kToolbarHeight,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      serviceDetails?.data?.about ?? '',
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.offeredBy,
                                      style: kRegularThemeTextStyle,
                                    ),
                                    ItemSalon(
                                      salonData: serviceDetails?.data?.salon,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 55,
                              width: double.infinity,
                              child: TextButton(
                                style: kButtonThemeStyle,
                                onPressed: () {
                                  if (ConstRes.userIdValue == -1) {
                                    Get.to(() => const LoginOptionScreen());
                                    return;
                                  }
                                  Get.to(() => const ConfirmBookingScreen(),
                                      arguments: {
                                        ConstRes.salonData:
                                            serviceDetails?.data?.salon,
                                        ConstRes.services:
                                            serviceDetailsBloc.selectedServices,
                                      });
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.bookService,
                                  style: kRegularWhiteTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      color: ColorRes.smokeWhite1,
                    ),
            );
          },
        ),
      ),
    );
  }
}

class TopBarOfServiceDetails extends StatelessWidget {
  final ServiceDetails? serviceDetails;
  final bool toolbarIsExpand;
  final UserData? userData;

  const TopBarOfServiceDetails({
    super.key,
    required this.toolbarIsExpand,
    this.serviceDetails,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 60,
      expandedHeight: MediaQuery.of(context).size.width + 40,
      pinned: true,
      floating: true,
      backgroundColor: ColorRes.smokeWhite,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BgRoundImageWidget(
          image: AssetRes.icBack,
          imagePadding: 6,
          imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
          bgColor: !toolbarIsExpand
              ? ColorRes.smokeWhite1
              : ColorRes.white.withOpacity(0.2),
          onTap: () => Get.back(),
        ),
      ),
      elevation: 0,
      title: Text(
        !toolbarIsExpand ? (serviceDetails?.data?.title ?? '') : '',
        style:
            kSemiBoldTextStyle.copyWith(color: ColorRes.mortar, fontSize: 18),
      ),
      titleTextStyle: kSemiBoldTextStyle.copyWith(
        color: ColorRes.mortar,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleImageWidget(
            toolbarIsExpand: toolbarIsExpand,
            isFav: userData
                ?.isFavouriteService(serviceDetails?.data?.id?.toInt() ?? 0),
            serviceData: serviceDetails?.data,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: BgRoundImageWidget(
            onTap: () async {
              BranchUniversalObject buo = BranchUniversalObject(
                canonicalIdentifier: 'flutter/branch',
                title: serviceDetails?.data?.title ?? '',
                imageUrl:
                    '${ConstRes.itemBaseUrl}${serviceDetails?.data?.images?[0].image}',
                contentDescription: serviceDetails?.data?.about ?? '',
                publiclyIndex: true,
                locallyIndex: true,
                contentMetadata: BranchContentMetaData()
                  ..addCustomMetadata(ConstRes.serviceId,
                      serviceDetails?.data?.id?.toInt() ?? -1),
              );
              BranchLinkProperties lp = BranchLinkProperties(
                  channel: 'facebook',
                  feature: 'sharing',
                  stage: 'new share',
                  tags: ['one', 'two', 'three']);
              BranchResponse response = await FlutterBranchSdk.getShortUrl(
                  buo: buo, linkProperties: lp);
              if (response.success) {
                Share.share(
                  'Check out this Profile ${response.result}',
                  subject: 'Look ${serviceDetails?.data?.title}',
                );
              } else {}
            },
            image: AssetRes.icShare,
            imagePadding: 8,
            imageColor: !toolbarIsExpand ? ColorRes.mortar : ColorRes.white,
            bgColor: !toolbarIsExpand
                ? ColorRes.smokeWhite1
                : ColorRes.white.withOpacity(0.2),
          ),
        ),
      ],
      flexibleSpace: serviceDetails == null
          ? const LoadingData(
              color: ColorRes.smokeWhite1,
            )
          : FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: SizedBox(
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: PageView(
                        children: List<Widget>.generate(
                            serviceDetails?.data?.images?.length ?? 0, (index) {
                          return FadeInImage.assetNetwork(
                            placeholder: '1',
                            width: double.infinity,
                            image:
                                '${ConstRes.itemBaseUrl}${serviceDetails?.data?.images?[index].image}',
                            fit: BoxFit.cover,
                            imageErrorBuilder: errorBuilderForImage,
                            placeholderErrorBuilder: loadingImage,
                          );
                        }),
                      ),
                    ),
                    Column(
                      children: [
                        const Spacer(),
                        Stack(
                          children: [
                            Positioned(
                              top: 15,
                              left: 0,
                              right: 0,
                              bottom: -5,
                              child: Container(
                                color: ColorRes.smokeWhite,
                                height: 12,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: ColorRes.themeColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    AppRes.getGenderTypeInStringFromNumber(
                                        context,
                                        serviceDetails?.data?.gender ?? 0),
                                    style: kLightWhiteTextStyle.copyWith(
                                      letterSpacing: 2,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: ColorRes.themeColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    AppRes.convertTimeForService(
                                        serviceDetails?.data?.serviceTime ?? 0),
                                    style: kLightWhiteTextStyle.copyWith(
                                      letterSpacing: 1,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: ColorRes.smokeWhite,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceDetails?.data?.title ?? '',
                                style: kBoldWhiteTextStyle.copyWith(
                                  color: ColorRes.charcoal,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.by} ${serviceDetails?.data?.salon?.salonName ?? ''}',
                                style: kThinWhiteTextStyle.copyWith(
                                  color: ColorRes.titleText,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${AppRes.currency}${((serviceDetails?.data?.price ?? 0) - AppRes.calculateDiscountByPercentage(serviceDetails?.data?.price, serviceDetails?.data?.discount)).toStringAsFixed(1)}',
                                    style: kBoldThemeTextStyle.copyWith(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Visibility(
                                    visible: serviceDetails?.data?.discount !=
                                            null &&
                                        serviceDetails?.data?.discount != 0,
                                    child: Text(
                                      '${AppRes.currency}${serviceDetails?.data?.price ?? 0}',
                                      style: kLightWhiteTextStyle.copyWith(
                                        color: ColorRes.empress,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Visibility(
                                    visible: serviceDetails?.data?.discount !=
                                            null &&
                                        serviceDetails?.data?.discount != 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: ColorRes.pumpkin15,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          const Image(
                                            image: AssetImage(AssetRes.icTag),
                                            color: ColorRes.pumpkin,
                                            height: 20,
                                            width: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '-${serviceDetails?.data?.discount}%',
                                            style: kRegularTextStyle.copyWith(
                                              color: ColorRes.pumpkin,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class ToggleImageWidget extends StatefulWidget {
  const ToggleImageWidget({
    super.key,
    required this.toolbarIsExpand,
    this.isFav,
    this.serviceData,
    this.userData,
  });

  final ServiceData? serviceData;
  final UserData? userData;
  final bool toolbarIsExpand;
  final bool? isFav;

  @override
  State<ToggleImageWidget> createState() => _ToggleImageWidgetState();
}

class _ToggleImageWidgetState extends State<ToggleImageWidget> {
  bool? isFav;

  @override
  Widget build(BuildContext context) {
    if (widget.isFav != null && isFav == null) {
      isFav ??= widget.isFav ?? false;
    }
    return BgRoundImageWidget(
      onTap: () {
        if (ConstRes.userIdValue == -1) {
          Get.to(() => const LoginOptionScreen());
          return;
        }
        ApiService()
            .editUserDetails(
                favouriteServices: widget.serviceData?.id?.toString())
            .then((value) {});
        isFav = !isFav!;
        setState(() {});
      },
      image:
          (isFav != null && isFav!) ? AssetRes.icFav : AssetRes.icUnFavourite,
      imagePadding: (isFav != null && isFav!) ? 9 : 10,
      imageColor: (isFav != null && isFav!)
          ? ColorRes.bitterSweet
          : (!widget.toolbarIsExpand ? ColorRes.mortar : ColorRes.white),
      bgColor: !widget.toolbarIsExpand
          ? ColorRes.smokeWhite1
          : ColorRes.white.withOpacity(0.2),
    );
  }
}
