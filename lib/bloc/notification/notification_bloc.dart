import 'package:cutfx/model/notification/notification.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<FetchNotificationEvent>((event, emit) async {
      MyNotification walletStatement =
          await ApiService().fetchUserNotification(notifications.length);
      notifications.addAll(walletStatement.data ?? []);
      emit(NotificationDataFoundState());
    });
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchNotificationEvent());
      }
    });
    add(FetchNotificationEvent());
  }

  ScrollController scrollController = ScrollController();
  bool isFetching = false;
  List<Data> notifications = [];
}
