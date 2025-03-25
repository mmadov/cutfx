import 'dart:async';
import 'dart:io';

import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/screens/main/main_screen.dart';
import 'package:cutfx/screens/salon/salon_details_screen.dart';
import 'package:cutfx/screens/service/service_detail_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/route_manager.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({super.key});

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    manageNotification();
    initData();
    return Scaffold(
      body: Container(
        color: ColorRes.themeColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(
                    textSize: 34,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .bookYourHaircutMassageSpanWaxingOrColoringwheneverNtheMoment,
                    style: kThinWhiteTextStyle.copyWith(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> manageNotification() async {
    await FlutterBranchSdk.init();
    FlutterBranchSdk.listSession().listen((data) {
      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        //Link clicked. Add logic to get link data
        if (data.containsKey(ConstRes.salonId_)) {
          Get.to(
            () => const SalonDetailsScreen(),
            arguments: int.parse(data[ConstRes.salonId_].toString()),
          );
        } else if (data.containsKey(ConstRes.serviceId)) {
          Get.to(() => const ServiceDetailScreen(),
              arguments: int.parse(data[ConstRes.serviceId].toString()));
        }
      }
    }, onError: (error) {});
    SharePref sharePref = await SharePref().init();
    Stripe.publishableKey =
        sharePref.getSettings()?.data?.stripePublishableKey ?? '';
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.subscribeToTopic(AppRes.topicName);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'cutfx', // id
      'Notification', // title
      // 'This channel is used for bubbly notifications.', // description
      importance: Importance.max,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) return;
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      FlutterLocalNotificationsPlugin().initialize(initializationSettings);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && apple != null) {
        flutterLocalNotificationsPlugin.show(
            0,
            notification.title,
            notification.body,
            const NotificationDetails(iOS: DarwinNotificationDetails()));
      }
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                // other properties...
              ),
            ));
      }
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    return true;
  }

  void initData() async {
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    SharePref sharedPref = await SharePref().init();
    String? token;
    if (apnsToken != null && Platform.isIOS) {
      // APNS token is available, make FCM plugin API requests...
      token = await FirebaseMessaging.instance.getToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }
    sharedPref.saveString(ConstRes.deviceToken, token);
    await ApiService().fetchGlobalSettings();

    AppRes.currency = sharedPref.getSettings()?.data?.currency ?? '';
    SalonUser? salon = sharedPref.getSalonUser();
    ConstRes.userIdValue = salon?.data?.id?.toInt() ?? -1;
    // if (salon != null) {
    Get.off(() => MainScreen());
    // } else {
    //   Get.off(() => const LoginOptionScreen());
    // }}
  }
}
