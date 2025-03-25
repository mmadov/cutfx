import 'package:cutfx/bloc/messageuser/message_user_bloc.dart';
import 'package:cutfx/model/chat/chat.dart';
import 'package:cutfx/screens/chat/chat_screen.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MessagesListWidget extends StatelessWidget {
  const MessagesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageUserBloc, MessageUserState>(
      builder: (context, state) {
        MessageUserBloc messageUserBloc = context.read<MessageUserBloc>();
        return Expanded(
          child: messageUserBloc.userList.isEmpty
              ? const DataNotFound()
              : ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: messageUserBloc.userList.length,
                  itemBuilder: (context, index) {
                    Conversation conversation = messageUserBloc.userList[index];
                    return ItemMessagesUsers(
                      conversation: conversation,
                    );
                  },
                ),
        );
      },
    );
  }
}

class ItemMessagesUsers extends StatelessWidget {
  const ItemMessagesUsers({
    super.key,
    required this.conversation,
  });
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(() => const ChatScreen(), arguments: [
          conversation,
          context.read<MessageUserBloc>().userData
        ]);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: ColorRes.smokeWhite,
        ),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: FadeInImage.assetNetwork(
                width: 55,
                height: 55,
                fit: BoxFit.cover,
                image: '${ConstRes.itemBaseUrl}${conversation.user?.image}',
                imageErrorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: Container(
                      height: 55,
                      width: 55,
                      padding:
                          const EdgeInsets.only(top: 12, left: 5, right: 5),
                      color: ColorRes.smokeWhite1,
                      child: const Center(
                        child: Image(
                          image: AssetImage(AssetRes.icProfile),
                        ),
                      ),
                    ),
                  );
                },
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: Container(
                      height: 55,
                      width: 55,
                      padding:
                          const EdgeInsets.only(top: 12, left: 5, right: 5),
                      color: ColorRes.smokeWhite1,
                      child: const Center(
                        child: Image(
                          image: AssetImage(AssetRes.icProfile),
                        ),
                      ),
                    ),
                  );
                },
                placeholder: '1',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.user?.username ?? '',
                    style: kSemiBoldTextStyle,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    conversation.lastMsg ?? '',
                    style: kLightWhiteTextStyle.copyWith(
                      color: ColorRes.subTitleText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppRes.timeAgo(DateTime.fromMillisecondsSinceEpoch(
                      int.parse(conversation.time ?? '0'))),
                  style: kLightWhiteTextStyle.copyWith(
                    color: ColorRes.darkGray,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Visibility(
                  visible: (conversation.user?.msgCount ?? 0) >= 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorRes.sun,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    height: 26,
                    width: 26,
                    child: Center(
                      child: Text(
                        '${conversation.user?.msgCount}',
                        maxLines: 1,
                        style: kRegularWhiteTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
