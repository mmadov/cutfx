# ---Date: 19 Feb, 2025---

## Summary

- Update Notification Dependency & add Flutter Wave Payment Gateway

# **Updated Files**

-[api_service.dart](lib/service/api_service.dart)
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[pubspec.yaml](pubspec.yaml)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)
-[settings.gradle](android/settings.gradle)
-[welcome_screen.dart](lib/screens/welcome/welcome_screen.dart)

# **Added Files**

-None

# **Deleted Files**

-None

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 13 Feb, 2025---

## Summary

- Update Dependencies

# **Updated Files**

-[build.gradle](android/app/build.gradle)
-[const_res.dart](lib/utils/const_res.dart)
-[gradle-wrapper.properties](android/gradle/wrapper/gradle-wrapper.properties)
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[Podfile](ios/Podfile)
-[pubspec.yaml](pubspec.yaml)
-[settings.gradle](android/settings.gradle)
-[welcome_screen.dart](lib/screens/welcome/welcome_screen.dart)

# **Added Files**

-None

# **Deleted Files**

-None

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 5 Dec, 2024---

## Summary

- Slots are now attached with barbers.
- So that appointments gets booked & managed based on barbers availability.

# **Updated Files**

-[add_addresses_screen.dart](lib/screens/address/add_addresses_screen.dart)
-[add_rating_bottom_sheet.dart](lib/screens/bookingdetail/add_rating_bottom_sheet.dart)
-[api_service.dart](lib/service/api_service.dart)
-[app_res.dart](lib/utils/app_res.dart)
-[booked_screen.dart](lib/screens/payment/booked_screen.dart)
-[booking_detail_bloc.dart](lib/bloc/bookingdetail/booking_detail_bloc.dart)
-[booking_detail_screen.dart](lib/screens/bookingdetail/booking_detail_screen.dart)
-[booking_screen.dart](lib/screens/booking/booking_screen.dart)
-[bookings_bloc.dart](lib/bloc/bookings/bookings_bloc.dart)
-[bottom_selected_item_bar.dart](lib/screens/chat/bottom_selected_item_bar.dart)
-[categories.dart](lib/screens/home/categories.dart)
-[categories_screen.dart](lib/screens/categories/categories_screen.dart)
-[categories_with_salons.dart](lib/screens/home/categories_with_salons.dart)
-[change_language.dart](lib/screens/changelanguage/change_language.dart)
-[chat_screen.dart](lib/screens/chat/chat_screen.dart)
-[chnage_password_bottom.dart](lib/screens/profile/chnage_password_bottom.dart)
-[choose_barber_screen.dart](lib/screens/barber/choose_barber_screen.dart)
-[confirm_booking.dart](lib/screens/booking/confirm_booking.dart)
-[confirm_booking_bloc.dart](lib/bloc/confirmbooking/confirm_booking_bloc.dart)
-[const_res.dart](lib/utils/const_res.dart)
-[coupon_bottom_sheet.dart](lib/screens/payment/coupon_bottom_sheet.dart)
-[custom_bottom_sheet.dart](lib/utils/custom/custom_bottom_sheet.dart)
-[custom_dialog.dart](lib/utils/custom/custom_dialog.dart)
-[custom_widget.dart](lib/utils/custom/custom_widget.dart)
-[delete_account_bottom.dart](lib/screens/profile/delete_account_bottom.dart)
-[drawer_screen.dart](lib/screens/drawer/drawer_screen.dart)
-[edit_profile_screen.dart](lib/screens/edit_profile_screen.dart)
-[email_login_screen.dart](lib/screens/login/email_login_screen.dart)
-[email_registration_screen.dart](lib/screens/login/email_registration_screen.dart)
-[explore_salon_on_map.dart](lib/screens/salononmap/explore_salon_on_map.dart)
-[faqs.dart](lib/model/faq/faqs.dart)
-[favourite_screen.dart](lib/screens/fav/favourite_screen.dart)
-[filter_bottom_sheet.dart](lib/screens/search/filter_bottom_sheet.dart)
-[forgot_password.dart](lib/screens/login/forgot_password.dart)
-[gallery_screen.dart](lib/screens/gallery/gallery_screen.dart)
-[help_and_faq_screen.dart](lib/screens/help&faq/help_and_faq_screen.dart)
-[history_widget.dart](lib/screens/booking/history_widget.dart)
-[home_bloc.dart](lib/bloc/home/home_bloc.dart)
-[home_screen.dart](lib/screens/home/home_screen.dart)
-[image_preview_screen.dart](lib/screens/preview/image_preview_screen.dart)
-[image_send_sheet.dart](lib/bloc/chat/image_send_sheet.dart)
-[intl_ar.arb](lib/l10n/intl_ar.arb)
-[intl_da.arb](lib/l10n/intl_da.arb)
-[intl_de.arb](lib/l10n/intl_de.arb)
-[intl_el.arb](lib/l10n/intl_el.arb)
-[intl_en.arb](lib/l10n/intl_en.arb)
-[intl_es.arb](lib/l10n/intl_es.arb)
-[intl_fr.arb](lib/l10n/intl_fr.arb)
-[intl_hi.arb](lib/l10n/intl_hi.arb)
-[intl_id.arb](lib/l10n/intl_id.arb)
-[intl_it.arb](lib/l10n/intl_it.arb)
-[intl_ja.arb](lib/l10n/intl_ja.arb)
-[intl_ko.arb](lib/l10n/intl_ko.arb)
-[intl_nb.arb](lib/l10n/intl_nb.arb)
-[intl_nl.arb](lib/l10n/intl_nl.arb)
-[intl_pl.arb](lib/l10n/intl_pl.arb)
-[intl_pt.arb](lib/l10n/intl_pt.arb)
-[intl_ru.arb](lib/l10n/intl_ru.arb)
-[intl_th.arb](lib/l10n/intl_th.arb)
-[intl_tr.arb](lib/l10n/intl_tr.arb)
-[intl_vi.arb](lib/l10n/intl_vi.arb)
-[intl_zh.arb](lib/l10n/intl_zh.arb)
-[login_option_screen.dart](lib/screens/login/login_option_screen.dart)
-[main.dart](lib/main.dart)
-[main_screen.dart](lib/screens/main/main_screen.dart)
-[make_payment_screen.dart](lib/screens/payment/make_payment_screen.dart)
-[manage_staff_bloc.dart](lib/bloc/choosestaff/manage_staff_bloc.dart)
-[map_screen.dart](lib/screens/map/map_screen.dart)
-[map_screen_controller.dart](lib/screens/map/map_screen_controller.dart)
-[message_screen.dart](lib/screens/message/message_screen.dart)
-[messages_list_widget.dart](lib/screens/message/messages_list_widget.dart)
-[my_qr_bottom_sheet.dart](lib/screens/bookingdetail/my_qr_bottom_sheet.dart)
-[near_by_salon.dart](lib/screens/home/near_by_salon.dart)
-[near_by_salon_screen.dart](lib/screens/nearbysalon/near_by_salon_screen.dart)
-[notification_screen.dart](lib/screens/notification/notification_screen.dart)
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[payout_history_screen.dart](lib/screens/payoutHistory/payout_history_screen.dart)
-[profile_booking_screen.dart](lib/screens/booking/profile_booking_screen.dart)
-[profile_screen.dart](lib/screens/profile/profile_screen.dart)
-[profile_top_bar_widget.dart](lib/screens/profile/profile_top_bar_widget.dart)
-[pubspec.yaml](pubspec.yaml)
-[re_schedule_bloc.dart](lib/bloc/reschedule/re_schedule_bloc.dart)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)
-[recharge_wallet_sheet.dart](lib/screens/payment/recharge_wallet_sheet.dart)
-[reschedule_bottom_sheet.dart](lib/screens/bookingdetail/reschedule_bottom_sheet.dart)
-[salon_awards_page.dart](lib/screens/salon/salon_awards_page.dart)
-[salon_by_cat_screen.dart](lib/screens/categories/salon_by_cat_screen.dart)
-[salon_details_page.dart](lib/screens/salon/salon_details_page.dart)
-[salon_details_screen.dart](lib/screens/salon/salon_details_screen.dart)
-[salon_gallery_page.dart](lib/screens/salon/salon_gallery_page.dart)
-[salon_on_map_bloc.dart](lib/bloc/salononmap/salon_on_map_bloc.dart)
-[salon_reviews_page.dart](lib/screens/salon/salon_reviews_page.dart)
-[salon_screen.dart](lib/screens/fav/salon_screen.dart)
-[salon_services_page.dart](lib/screens/salon/salon_services_page.dart)
-[search_salon_screen.dart](lib/screens/search/search_salon_screen.dart)
-[search_screen.dart](lib/screens/search/search_screen.dart)
-[search_service_screen.dart](lib/screens/search/search_service_screen.dart)
-[service_detail_screen.dart](lib/screens/service/service_detail_screen.dart)
-[service_screen.dart](lib/screens/fav/service_screen.dart)
-[setting.dart](lib/model/setting/setting.dart)
-[slot.dart](lib/model/slot/slot.dart)
-[style_res.dart](lib/utils/style_res.dart)
-[top_rated_salon.dart](lib/screens/home/top_rated_salon.dart)
-[top_rated_salon_screen.dart](lib/screens/toprated/top_rated_salon_screen.dart)
-[transaction_complete_sheet.dart](lib/screens/payment/transaction_complete_sheet.dart)
-[upcoming_widget.dart](lib/screens/booking/upcoming_widget.dart)
-[video_preview_screen.dart](lib/screens/preview/video_preview_screen.dart)
-[video_upload_dialog.dart](lib/screens/chat/video_upload_dialog.dart)
-[wallet_screen.dart](lib/screens/wallet/wallet_screen.dart)
-[web_view_screen.dart](lib/screens/web/web_view_screen.dart)
-[welcome_screen.dart](lib/screens/welcome/welcome_screen.dart)
-[withdraw_screen.dart](lib/screens/wallet/withdraw_screen.dart)

# **Added Files**

-[choose_your_expert_bottom.dart](lib/screens/barber/choose_your_expert_bottom.dart)

# **Deleted Files**

-None

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 16 Oct, 2024---

## Summary

-Solve Paypal Payment Issue

#### Added Files

None

#### Deleted Files

None

#### Updated Files

bloc
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)

lib
-[main.dart](lib/main.dart)

#### Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 13 Sep, 2024---

## Summary

-Remove FlutterWave Sdk

#### Added Files

None

#### Deleted Files

None

#### Updated Files

bloc
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)
-[salon_on_map_bloc.dart](lib/bloc/salononmap/salon_on_map_bloc.dart)

lib
-[pubspec.yaml](pubspec.yaml)

#### Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 1 Aug, 2024---

## Summary

-Update Payment Gateways (Add SslCommerz Payment)
-Solved Issue of Slot's Sorting

#### Added Files

None

#### Deleted Files

None

#### Updated Files

bloc
-[bookings_bloc.dart](lib/bloc/bookings/bookings_bloc.dart)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)
-[re_schedule_bloc.dart](lib/bloc/reschedule/re_schedule_bloc.dart)
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)

model
-[setting.dart](lib/model/setting/setting.dart)

screens
-[confirm_booking.dart](lib/screens/booking)
-[reschedule_bottom_sheet.dart](lib/screens/bookingdetail/reschedule_bottom_sheet.dart)

service
-[api_service.dart](lib/service/api_service.dart)

lib
-[pubspec.yaml](pubspec.yaml)

Android
-[settings.gradle](android/settings.gradle)

#### Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ---Date: 22 June, 2024---

# -Pay After Service Option added-

# -Serve At My Location address added-

# -Choose Barber Options added-

# **Added Files**

images
-[ic_menu_2.png](images/ic_menu_2.png)
-[ic_navigator2.png](images/ic_navigator2.png)
-[ic_user.png](images/ic_user.png)

bloc
-[add_address_bloc.dart](lib/bloc/address/add_address_bloc.dart)
-[add_address_event.dart](lib/bloc/address/add_address_event.dart)
-[add_address_state.dart](lib/bloc/address/add_address_state.dart)
-[manage_address_bloc.dart](lib/bloc/manageaddress/manage_address_bloc.dart)
-[manage_address_event.dart](lib/bloc/manageaddress/manage_address_event.dart)
-[manage_address_state.dart](lib/bloc/manageaddress/manage_address_state.dart)
-[manage_staff_bloc.dart](lib/bloc/choosestaff/manage_staff_bloc.dart)
-[manage_staff_event.dart](lib/bloc/choosestaff/manage_staff_event.dart)
-[manage_staff_state.dart](lib/bloc/choosestaff/manage_staff_state.dart)

model
-[staff.dart](lib/model/staff)
-[address.dart](lib/model/address/address.dart)

screens
-[add_addresses_screen.dart](lib/screens/address/add_addresses_screen.dart)
-[choose_barber_screen.dart](lib/screens/barber/choose_barber_screen.dart)
-[manage_my_addresses.dart](lib/screens/address/manage_my_addresses.dart)
-[map_screen.dart](lib/screens/map/map_screen.dart)
-[map_screen_controller.dart](lib/screens/map/map_screen_controller.dart)
-[salon_staff_page.dart](lib/screens/salon/salon_staff_page.dart)

# **Updated Files**

# *Android*

-[build.gradle](android/app/build.gradle)

# *iOS*

-[Info.plist](ios/Runner/Info.plist)

# *Flutter*

bloc
-[bookings_bloc.dart](lib/bloc/bookings/bookings_bloc.dart)
-[confirm_booking_bloc.dart](lib/bloc/confirmbooking/confirm_booking_bloc.dart)
-[login_bloc.dart](lib/bloc/login/login_bloc.dart)

model
-[salon.dart](lib/model/user/salon.dart)
-[booking.dart](lib/model/bookings/booking.dart)

screens
-[booking_detail_screen.dart](lib/screens/bookingdetail/booking_detail_screen.dart)
-[confirm_booking.dart](lib/screens/booking/confirm_booking.dart)
-[make_payment_screen.dart](lib/screens/payment/make_payment_screen.dart)
-[profile_screen.dart](lib/screens/profile/profile_screen.dart)
-[salon_details_screen.dart](lib/screens/salon/salon_details_screen.dart)
-[salon_screen.dart](lib/screens/fav/salon_screen.dart)
-[salon_services_page.dart](lib/screens/salon/salon_services_page.dart)
-[service_screen.dart](lib/screens/fav/service_screen.dart)
-[wallet_screen.dart](lib/screens/wallet/wallet_screen.dart)

service
-[api_service.dart](lib/service/api_service.dart)

utils
-[app_res.dart](lib/utils/app_res.dart)
-[asset_res.dart](lib/utils/asset_res.dart)
-[const_res.dart](lib/utils/const_res.dart)
-[custom_widget.dart](lib/utils/custom/custom_widget.dart)

l10n
-[intl_ar.arb](lib/l10n/intl_ar.arb)
-[intl_da.arb](lib/l10n/intl_da.arb)
-[intl_de.arb](lib/l10n/intl_de.arb)
-[intl_el.arb](lib/l10n/intl_el.arb)
-[intl_en.arb](lib/l10n/intl_en.arb)
-[intl_es.arb](lib/l10n/intl_es.arb)
-[intl_fr.arb](lib/l10n/intl_fr.arb)
-[intl_hi.arb](lib/l10n/intl_hi.arb)
-[intl_id.arb](lib/l10n/intl_id.arb)
-[intl_it.arb](lib/l10n/intl_it.arb)
-[intl_ja.arb](lib/l10n/intl_ja.arb)
-[intl_ko.arb](lib/l10n/intl_ko.arb)
-[intl_nb.arb](lib/l10n/intl_nb.arb)
-[intl_nl.arb](lib/l10n/intl_nl.arb)
-[intl_pl.arb](lib/l10n/intl_pl.arb)
-[intl_pt.arb](lib/l10n/intl_pt.arb)
-[intl_ru.arb](lib/l10n/intl_ru.arb)
-[intl_th.arb](lib/l10n/intl_th.arb)
-[intl_tr.arb](lib/l10n/intl_tr.arb)
-[intl_vi.arb](lib/l10n/intl_vi.arb)
-[intl_zh.arb](lib/l10n/intl_zh.arb)

lib
-[main.dart](lib/main.dart)
-[pubspec.yaml](pubspec.yaml)

## Note: Don't forget to change your credentials after updating file.

----------------------------------------------------------------------------------------------------

# ******* Date: 28 May, 2024 *******

# -Update pubspec.yaml & Gradle File.-

# -Change library of PayStack Payment gateway & Flutter Cluster Manager.-

# -Bug Fixes.-

# **Updated Files**

#android
-[build.gradle](./android/app/build.gradle)
-[build.gradle](./android/build.gradle)
-[gradle.properties](./android/gradle.properties)
-[gradle-wrapper.properties](./android/gradle/wrapper/gradle-wrapper.properties)
-[AndroidManifest.xml](./android/app/src/main/AndroidManifest.xml)
-[settings.gradle](./android/settings.gradle)
#flutter
-[bookings_bloc.dart](lib/bloc/bookings/bookings_bloc.dart)
-[payment_gateway.dart](lib/bloc/confirmbooking/payment_gateway.dart)
-[recharge_wallet_bloc.dart](lib/bloc/recharge/recharge_wallet_bloc.dart)
-[salon_details_bloc.dart](lib/bloc/salon/salon_details_bloc.dart)
-[welcome_screen.dart](lib/screens/welcome/welcome_screen.dart)
-[salon_on_map_bloc.dart](lib/bloc/salononmap/salon_on_map_bloc.dart)

## Notes: Don't forget to change your credentials after updating file.
