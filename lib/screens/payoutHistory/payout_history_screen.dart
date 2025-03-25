import 'package:cutfx/bloc/payout/payout_history_bloc.dart';
import 'package:cutfx/model/withdrawrequest/withdraw_requests.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PayoutHistoryScreen extends StatelessWidget {
  const PayoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayoutHistoryBloc(),
      child: Scaffold(
        body: Column(
          children: [
            ToolBarWidget(
              title: AppLocalizations.of(context)!.withdrawRequests,
            ),
            BlocBuilder<PayoutHistoryBloc, PayoutHistoryState>(
              builder: (context, state) {
                if (state is PayoutHistoryDataFoundState) {
                  PayoutHistoryBloc payoutHistoryBloc =
                      context.read<PayoutHistoryBloc>();
                  return Expanded(
                    child: payoutHistoryBloc.withdrawRequests.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                payoutHistoryBloc.withdrawRequests.length,
                            padding: const EdgeInsets.only(top: 10),
                            itemBuilder: (context, index) {
                              WithdrawRequestsData payoutHistoryData =
                                  payoutHistoryBloc.withdrawRequests[index];
                              return Container(
                                color: ColorRes.smokeWhite,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              payoutHistoryData.requestNumber ??
                                                  '',
                                              style: kMediumThemeTextStyle
                                                  .copyWith(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3,
                                              ),
                                              child: Text(
                                                '${AppLocalizations.of(context)!.account}${payoutHistoryData.accountNumber ?? ''}',
                                                style: kLightWhiteTextStyle
                                                    .copyWith(
                                                  color: ColorRes.mortar,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              AppRes.formatDate(
                                                AppRes.parseDate(
                                                    payoutHistoryData
                                                            .createdAt ??
                                                        ''),
                                              ),
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.mortar,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${AppRes.currency}${payoutHistoryData.amount}',
                                              style:
                                                  kBoldThemeTextStyle.copyWith(
                                                fontSize: 18,
                                                color: ColorRes.mortar,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppRes
                                                        .getBackgroundColorByStatus(
                                                            payoutHistoryData
                                                                    .status ??
                                                                0)
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 3,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppRes.getStringOfStatusByType(
                                                    payoutHistoryData.status ??
                                                        0),
                                                style: kRegularWhiteTextStyle
                                                    .copyWith(
                                                  fontSize: 15,
                                                  color: AppRes
                                                      .getBackgroundColorByStatus(
                                                          payoutHistoryData
                                                                  .status ??
                                                              0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const DataNotFound(),
                  );
                }
                return const Expanded(
                  child: LoadingData(
                    color: ColorRes.white,
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
