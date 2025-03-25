import 'package:cutfx/bloc/coupon/coupon_bloc.dart';
import 'package:cutfx/model/coupon/coupon.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CouponBottomSheet extends StatelessWidget {
  const CouponBottomSheet({super.key, this.onApplyCoupon});
  final Function(CouponData couponData)? onApplyCoupon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocProvider(
        create: (context) => CouponBloc(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.applyCoupon,
                        style: kSemiBoldThemeTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        AppLocalizations.of(context)!.tapOnACouponToApplyIt,
                        style: kLightWhiteTextStyle.copyWith(
                          color: ColorRes.empress,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: ColorRes.lavender,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(
                        Icons.close_rounded,
                        color: ColorRes.themeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<CouponBloc, CouponState>(
                  builder: (context, state) {
                    CouponBloc couponBloc = context.read<CouponBloc>();
                    return couponBloc.coupons != null &&
                            couponBloc.coupons!.isNotEmpty
                        ? ListView.builder(
                            itemCount: couponBloc.coupons?.length ?? 0,
                            padding: const EdgeInsets.only(
                              top: 0,
                            ),
                            itemBuilder: (context, index) {
                              CouponData? coupon = couponBloc.coupons?[index];
                              return CustomCircularInkWell(
                                onTap: () {
                                  if (coupon != null) {
                                    Get.back();
                                    onApplyCoupon?.call(coupon);
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: AspectRatio(
                                    aspectRatio: 1 / 0.3,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(AssetRes.bgCoupon),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    coupon?.heading ?? '',
                                                    style: kBoldThemeTextStyle
                                                        .copyWith(
                                                      color: ColorRes.neroDark,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    'MAX \$${coupon?.maxDiscountAmount ?? ''}',
                                                    style: kLightWhiteTextStyle
                                                        .copyWith(
                                                      color: ColorRes.mortar,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                coupon?.coupon ?? '',
                                                style: kBoldThemeTextStyle
                                                    .copyWith(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            coupon?.description ?? '',
                                            style: kRegularTextStyle.copyWith(
                                              color: ColorRes.mortar,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : couponBloc.coupons == null
                            ? const LoadingData(
                                color: ColorRes.white,
                              )
                            : const DataNotFound();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
