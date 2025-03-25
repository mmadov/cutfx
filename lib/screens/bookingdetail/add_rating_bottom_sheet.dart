import 'package:cutfx/bloc/addrating/add_rating_bloc.dart';
import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddRatingBottomSheet extends StatelessWidget {
  final String bookingId;

  const AddRatingBottomSheet({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocProvider(
        create: (context) => AddRatingBloc(),
        child: Container(
          decoration: const BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: BlocBuilder<AddRatingBloc, AddRatingState>(
            builder: (context, state) {
              AddRatingBloc addRatingBloc = context.read<AddRatingBloc>();
              addRatingBloc.bookingId = bookingId;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.addRatings,
                            style: kBoldThemeTextStyle,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .shareYourExperienceInFewWords,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.subTitleText,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const CloseButtonWidget(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar(
                    initialRating: 0,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star_rounded,
                        color: ColorRes.koroMiko,
                      ),
                      half: const Icon(
                        Icons.star_rounded,
                      ),
                      empty: const Icon(
                        Icons.star_rounded,
                        color: ColorRes.darkGray,
                      ),
                    ),
                    onRatingUpdate: addRatingBloc.onValueChange,
                    itemSize: 40,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorRes.smokeWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: addRatingBloc.reviewController,
                      style: kRegularTextStyle,
                      maxLines: 6,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${addRatingBloc.reviewController.text.length}/200',
                      style: kLightWhiteTextStyle.copyWith(
                        color: ColorRes.darkGray,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: TextButton(
                      style: kButtonThemeStyle,
                      onPressed: () {
                        addRatingBloc.tapOnContinue();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.continue_,
                        style: kRegularWhiteTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
