import 'package:cutfx/bloc/messageuser/message_user_bloc.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/message/messages_list_widget.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MessageScreen extends StatelessWidget {
  final Function()? onMenuClick;

  const MessageScreen({super.key, this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageUserBloc(),
      child: Column(
        children: [
          Container(
            color: ColorRes.themeColor5,
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  BgRoundImageWidget(
                    image: AssetRes.icMenu,
                    imagePadding: 8,
                    onTap: onMenuClick,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.messages,
                    style: kLightWhiteTextStyle.copyWith(
                      fontSize: 20,
                      color: ColorRes.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<MessageUserBloc, MessageUserState>(
            builder: (context, state) {
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: ColorRes.smokeWhite,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.search,
                          hintStyle: kRegularTextStyle.copyWith(
                            color: ColorRes.darkGray,
                          ),
                        ),
                        style: kRegularTextStyle.copyWith(
                          color: ColorRes.charcoal50,
                        ),
                        onChanged: (value) {
                          context.read<MessageUserBloc>().filterData(value);
                        },
                      ),
                    ),
                    const MessagesListWidget(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
