import 'package:cutfx/bloc/withdraw/withdraw_bloc.dart';
import 'package:cutfx/screens/login/email_registration_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WithDrawScreen extends StatelessWidget {
  const WithDrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WithdrawBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.withdrawRequest,
            ),
            BlocBuilder<WithdrawBloc, WithdrawState>(
              builder: (context, state) {
                WithdrawBloc withdrawBloc = context.read<WithdrawBloc>();
                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.amount,
                            style: kRegularTextStyle,
                          ),
                          Text(
                            '${AppRes.currency}${withdrawBloc.userData?.wallet ?? ''}',
                            style: kRegularThemeTextStyle.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.bankName,
                            controller: withdrawBloc.bankNameController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.accountNumber,
                            controller: withdrawBloc.accountNumberController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!
                                .reEnterAccountNumber,
                            controller: withdrawBloc.reAccountNumberController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.holdersName,
                            controller: withdrawBloc.holdersNameController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.swiftCode,
                            controller: withdrawBloc.swiftCodeController,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<WithdrawBloc, WithdrawState>(
              builder: (context, state) {
                return SafeArea(
                  top: false,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    width: double.infinity,
                    height: 55,
                    child: TextButton(
                      style: kButtonThemeStyle,
                      onPressed: () {
                        context.read<WithdrawBloc>().tapOnContinue();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.continue_,
                        style: kRegularWhiteTextStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
