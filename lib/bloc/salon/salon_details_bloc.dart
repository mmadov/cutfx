import 'package:cutfx/model/chat/chat.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/chat/chat_screen.dart';
import 'package:cutfx/screens/login/login_option_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/firebase_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../utils/app_res.dart';

part 'salon_details_event.dart';
part 'salon_details_state.dart';

class SalonDetailsBloc extends Bloc<SalonDetailsEvent, SalonDetailsState> {
  SalonDetailsBloc() : super(SalonDetailsInitial()) {
    on<FetchSalonDataEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      Salon salon = await ApiService().fetchSalonDetails(Get.arguments);
      salonData = salon.data;
      categories = salonData?.categories
              ?.where((element) => element.services!.isNotEmpty)
              .toList() ??
          [];
      userData = sharePref.getSalonUser()?.data;
      emit(SalonDataFetched(salon));
    });
    add(FetchSalonDataEvent());
  }

  SalonData? salonData;
  UserData? userData;
  List<Categories> categories = [];
  List<Services> selectedServices = [];

  void onChatBtnTap() {
    if (ConstRes.userIdValue == -1) {
      Get.to(() => const LoginOptionScreen());
      return;
    }
    ChatUser chatUser = ChatUser(
        image: salonData?.images?[0].image ?? '',
        msgCount: 0,
        userid: salonData?.id?.toInt() ?? -1,
        userIdentity: '${FirebaseRes.sl}${salonData?.email}',
        username: salonData?.salonName);
    Conversation conversation = Conversation(
        time: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId:
            '${FirebaseRes.ct}${userData?.identity}${FirebaseRes.sl}${salonData?.email}',
        deletedId: '',
        isDeleted: false,
        lastMsg: '',
        newMsg: '',
        user: chatUser);
    Get.to(() => const ChatScreen(), arguments: [conversation, userData]);
  }

  bool isSelected(int id) {
    for (Services? services in selectedServices) {
      if (services?.id == id) {
        return true;
      }
    }
    return false;
  }

  int totalRates() {
    int totalPrice = 0;
    for (Services? services in selectedServices) {
      if (services != null) {
        totalPrice = totalPrice +
            (services.price?.toInt() ?? 0) -
            AppRes.calculateDiscountByPercentage(services.price?.toInt() ?? 0,
                    services.discount?.toInt() ?? 0)
                .toInt();
      }
    }
    return totalPrice;
  }
}
