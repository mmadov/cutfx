import 'package:cutfx/screens/search/filter_bottom_sheet.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final Function()? onButtonClick;
  final Function()? onCloseClick;

  const ConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    this.onButtonClick,
    this.onCloseClick,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Wrap(
          verticalDirection: VerticalDirection.down,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: kBoldThemeTextStyle,
                ),
                const Spacer(),
                CloseButtonWidget(
                  onTap: onCloseClick,
                ),
              ],
            ),
            Visibility(
              visible: description.isNotEmpty,
              child: const SizedBox(
                height: 50,
              ),
            ),
            Visibility(
              visible: description.isNotEmpty,
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: kRegularWhiteTextStyle.copyWith(
                  color: ColorRes.mortar,
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(top: 50),
                child: TextButton(
                  style: kButtonThemeStyle,
                  onPressed: onButtonClick,
                  child: Text(
                    buttonText,
                    style: kRegularWhiteTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
