import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutfx/bloc/confirmbooking/payment_gateway.dart';
import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/model/bookings/booking.dart';
import 'package:cutfx/model/bookings/booking_details.dart';
import 'package:cutfx/model/cat/categories.dart' as cat;
import 'package:cutfx/model/coupon/coupon.dart';
import 'package:cutfx/model/faq/faqs.dart';
import 'package:cutfx/model/fav/favourite_data.dart';
import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/model/notification/notification.dart';
import 'package:cutfx/model/rest/get_path.dart';
import 'package:cutfx/model/rest/rest_response.dart';
import 'package:cutfx/model/review/salon_review.dart';
import 'package:cutfx/model/salonbycat/salon_by_cat.dart';
import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/service/services.dart' as service;
import 'package:cutfx/model/service/services_details.dart';
import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/slot/slot.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/model/wallet/wallet_statement.dart';
import 'package:cutfx/model/withdrawrequest/withdraw_requests.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/firebase_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../model/user/salon.dart';

class ApiService {
  Future<SalonUser> registerUser({
    required String email,
    required String fullname,
    required int loginType,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.registerUser),
    );

    SharePref sharePref = await SharePref().init();
    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.identity] = email;
    request.fields[ConstRes.fullname] = fullname;
    request.fields[ConstRes.deviceType] = Platform.isAndroid ? '1' : '2';
    request.fields[ConstRes.deviceToken] =
        sharePref.getString(ConstRes.deviceToken) ?? 'q';
    request.fields[ConstRes.email] = email;
    request.fields[ConstRes.loginType] =
        loginType == 0 ? '3' : loginType.toString();

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    print(responseJson);
    if (loginType != 0) {
      sharePref.saveString(AppRes.user, respStr);
      SalonUser salon = SalonUser.fromJson(responseJson);
      ConstRes.userIdValue = salon.data?.id?.toInt() ?? -1;
    }
    return SalonUser.fromJson(responseJson);
  }

  Future<HomePageData> fetchHomePageData() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchHomePageData),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
    );
    final responseJson = jsonDecode(response.body);

    return HomePageData.fromJson(responseJson);
  }

  Future<FavouriteData> fetchFavoriteData() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchFavoriteData),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return FavouriteData.fromJson(responseJson);
  }

  Future<SalonUser> editUserDetails({
    String? fullname,
    String? phoneNumber,
    bool? isNotification,
    String? favouriteSalons,
    String? favouriteServices,
    String? deviceToken,
    File? profileImage,
  }) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.editUserDetails),
    );
    SharePref sharePref = await SharePref().init();
    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.userId] = ConstRes.userIdValue.toString();
    if (fullname != null) {
      request.fields[ConstRes.fullname] = fullname;
    }
    if (phoneNumber != null) {
      request.fields[ConstRes.phoneNumber] = phoneNumber;
    }
    if (isNotification != null) {
      request.fields[ConstRes.isNotification] =
          isNotification ? 1.toString() : 0.toString();
    }
    if (deviceToken != null) {
      request.fields[ConstRes.deviceToken] = deviceToken;
    }
    if (favouriteSalons != null) {
      List<String> list =
          sharePref.getSalonUser()?.data?.favouriteSalons?.split(',') ?? [];
      if (list.isEmpty || !list.contains(favouriteSalons)) {
        list.add(favouriteSalons);
      } else {
        list.remove(favouriteSalons);
      }

      request.fields[ConstRes.favouriteSalons] = list.join(',');
    }
    if (favouriteServices != null) {
      List<String> list =
          sharePref.getSalonUser()?.data?.favouriteServices?.split(',') ?? [];
      if (list.isEmpty || !list.contains(favouriteServices)) {
        list.add(favouriteServices);
      } else {
        list.remove(favouriteServices);
      }

      request.fields[ConstRes.favouriteServices] = list.join(',');
    }
    if (profileImage != null) {
      request.files.add(http.MultipartFile(ConstRes.profileImage,
          profileImage.readAsBytes().asStream(), profileImage.lengthSync(),
          filename: profileImage.path.split("/").last));
    }

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    sharePref.saveString(AppRes.user, respStr);

    SalonUser salon = SalonUser.fromJson(responseJson);
    ConstRes.userIdValue = salon.data?.id?.toInt() ?? -1;
    return SalonUser.fromJson(responseJson);
  }

  Future<Salon> fetchSalonDetails(int salonId) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonDetails),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.salonId_: salonId.toString(),
      },
    );

    final responseJson = jsonDecode(response.body);
    return Salon.fromJson(responseJson);
  }

  Future<SalonReview> fetchSalonReviews(int salonID, int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonReviews),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.salonId_: salonID.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return SalonReview.fromJson(responseJson);
  }

  Future<SalonByCat> salonAndServiceByCategory(int salonID) async {
    final response = await http.post(
      Uri.parse(ConstRes.salonAndServiceByCategory),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {ConstRes.categoryId: salonID.toString()},
    );
    final responseJson = jsonDecode(response.body);
    return SalonByCat.fromJson(responseJson);
  }

  Future<cat.Categories> fetchSalonCategories() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonCategories),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
    );
    final responseJson = jsonDecode(response.body);
    return cat.Categories.fromJson(responseJson);
  }

  Future<SalonByCoordinates> fetchSalonByCoordinates({
    int? catID,
    String? lat,
    String? long,
  }) async {
    Map<String, String> body = catID != null && catID != -1
        ? {
            ConstRes.categoryId: catID.toString(),
            ConstRes.lat: lat ?? '',
            ConstRes.long: long ?? '',
            ConstRes.km: '7',
          }
        : {
            ConstRes.lat: '21.2408',
            ConstRes.long: '72.8806',
            ConstRes.km: '7',
          };
    final response = await http.post(
      Uri.parse(ConstRes.fetchSalonByCoordinates),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: body,
    );
    final responseJson = jsonDecode(response.body);
    return SalonByCoordinates.fromJson(responseJson);
  }

  Future<ServiceDetails> fetchService(int serviceId) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchService),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {ConstRes.serviceId: serviceId.toString()},
    );
    final responseJson = jsonDecode(response.body);
    return ServiceDetails.fromJson(responseJson);
  }

  Future<Coupon> fetchCoupons() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchCoupons),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {ConstRes.userId: ConstRes.userIdValue.toString()},
    );
    final responseJson = jsonDecode(response.body);
    return Coupon.fromJson(responseJson);
  }

  Future<Setting> fetchGlobalSettings() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchGlobalSettings),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    SharePref sharePref = await SharePref().init();
    sharePref.saveString(AppRes.settings, response.body);
    AppRes.currency = sharePref.getSettings()?.data?.currency ?? '';
    return Setting.fromJson(responseJson);
  }

  createPaymentIntent(
      {required String amount,
      required String currency,
      required String authKey}) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      http.Response response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $authKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<RestResponse> addMoneyToUserWallet(
      {num? amount,
      required String transactionId,
      required String transactionSummary,
      required int paymentGateway}) async {
    http.Response response = await http.post(
      Uri.parse(ConstRes.addMoneyToUserWallet),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.amount: amount.toString(),
        ConstRes.gateway: paymentGateway.toString(),
        ConstRes.transactionId: transactionId,
        ConstRes.transactionSummary: transactionSummary,
      },
    );
    await fetchMyUserDetails();
    return RestResponse.fromJson(jsonDecode(response.body));
  }

  Future<RestResponse> addUserAddress({
    required String name,
    required String mobile,
    required String address,
    required String locality,
    required String city,
    required String pin,
    required String country,
    required String state,
    required int type,
    required String latitude,
    required String longitude,
  }) async {
    http.Response response = await http.post(
      Uri.parse(ConstRes.addUserAddress),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.name: name,
        ConstRes.mobile: mobile,
        ConstRes.address: address,
        ConstRes.locality: locality,
        ConstRes.city: city,
        ConstRes.pin: pin,
        ConstRes.country: country,
        ConstRes.state: state,
        ConstRes.type: type.toString(),
        ConstRes.latitude: latitude,
        ConstRes.longitude: longitude,
      },
    );
    await fetchMyUserDetails();
    return RestResponse.fromJson(jsonDecode(response.body));
  }

  Future<RestResponse> editUserAddress({
    required int addressId,
    required String name,
    required String mobile,
    required String address,
    required String locality,
    required String city,
    required String pin,
    required String country,
    required String state,
    required int type,
    required String latitude,
    required String longitude,
  }) async {
    http.Response response = await http.post(
      Uri.parse(ConstRes.editUserAddress),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.addressId: addressId.toString(),
        ConstRes.name: name,
        ConstRes.mobile: mobile,
        ConstRes.address: address,
        ConstRes.locality: locality,
        ConstRes.city: city,
        ConstRes.pin: pin,
        ConstRes.country: country,
        ConstRes.state: state,
        ConstRes.type: type.toString(),
        ConstRes.latitude: latitude,
        ConstRes.longitude: longitude,
      },
    );
    await fetchMyUserDetails();
    return RestResponse.fromJson(jsonDecode(response.body));
  }

  Future<RestResponse> deleteUserAddress(int addressId) async {
    final response = await http.post(
      Uri.parse(ConstRes.deleteUserAddress),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.addressId: addressId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<BookingDetails> placeBooking({
    required int salonId_,
    required String date,
    required String time,
    required int duration,
    required String services,
    required int payableAmount,
    required int isCouponApplied,
    required String couponTitle,
    required int couponId,
    required int discountAmount,
    required int serviceAmount,
    required int subtotal,
    required int totalTaxAmount,
    required int paymentType,
    required int serviceLocation,
    int? addressId,
    int? staffId,
  }) async {
    Map<String, String> body = {};
    body[ConstRes.userId] = ConstRes.userIdValue.toString();
    body[ConstRes.salonId_] = salonId_.toString();
    body[ConstRes.date] = date;
    body[ConstRes.time] = time;
    body[ConstRes.duration] = duration.toString();
    body[ConstRes.services] = services;
    body[ConstRes.payableAmount] = payableAmount.toString();
    body[ConstRes.isCouponApplied] = isCouponApplied.toString();
    body[ConstRes.couponTitle] = couponTitle;
    body[ConstRes.couponId] = couponId.toString();
    body[ConstRes.discountAmount] = discountAmount.toString();
    body[ConstRes.serviceAmount] = serviceAmount.toString();
    body[ConstRes.subtotal] = subtotal.toString();
    body[ConstRes.totalTaxAmount] = totalTaxAmount.toString();
    if (staffId != null) {
      body[ConstRes.staffId] = staffId.toString();
    }
    if (addressId != null && addressId != -1) {
      body[ConstRes.addressId] = addressId.toString();
    }
    body[ConstRes.serviceLocation] = serviceLocation.toString();

    ///PaymentType 0.PrePaid 1.PayAfterService
    body[ConstRes.paymentType] = paymentType.toString();
    http.Response response = await http.post(
      Uri.parse(ConstRes.placeBooking),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: body,
    );
    await fetchMyUserDetails();
    return BookingDetails.fromJson(jsonDecode(response.body));
  }

  Future<SalonUser> fetchMyUserDetails() async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.fetchUserDetails),
    );

    SharePref sharePref = await SharePref().init();
    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.userId] = ConstRes.userIdValue.toString();

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    sharePref.saveString(AppRes.user, respStr);

    SalonUser salon = SalonUser.fromJson(responseJson);
    ConstRes.userIdValue = salon.data?.id?.toInt() ?? -1;
    return SalonUser.fromJson(responseJson);
  }

  Future<Booking> fetchUserUpcomingBookings(int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchUserBookings),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return Booking.fromJson(responseJson);
  }

  Future<Address> fetchMyAddress() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchMyAddress),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return Address.fromJson(responseJson);
  }

  Future<Booking> fetchAcceptedPendingBookingsOfSalonByDate(
      int salonId, String date) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchAcceptedPendingBookingsOfSalonByDate),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.salonId_: salonId.toString(),
        ConstRes.date: date,
      },
    );
    final responseJson = jsonDecode(response.body);
    return Booking.fromJson(responseJson);
  }

  Future<BookingDetails> fetchBookingDetails(String bookingId) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchBookingDetails),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.bookingId: bookingId.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return BookingDetails.fromJson(responseJson);
  }

  Future<RestResponse> cancelBooking(String bookingId) async {
    final response = await http.post(
      Uri.parse(ConstRes.cancelBooking),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.bookingId: bookingId,
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> addRating(
      String bookingId, int rating, String comment) async {
    final response = await http.post(
      Uri.parse(ConstRes.addRating),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.bookingId: bookingId,
        ConstRes.rating: rating.toString(),
        ConstRes.comment: comment
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> rescheduleBooking(
    String bookingId,
    String date,
    String time,
    int? staffId,
  ) async {
    final response = await http.post(
      Uri.parse(ConstRes.rescheduleBooking),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.bookingId: bookingId,
        ConstRes.staffId: staffId?.toString(),
        ConstRes.date: date.toString(),
        ConstRes.time: time
      },
    );
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<GetPath> uploadFileGivePath(File? image) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.uploadFileGivePath),
    );
    request.headers.addAll({
      ConstRes.apiKey: ConstRes.apiKeyValue,
    });
    if (image != null) {
      request.files.add(
        http.MultipartFile(
          ConstRes.file,
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split("/").last,
        ),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return GetPath.fromJson(responseJson);
  }

  Future pushNotification(
      {required String authorization,
      required String title,
      required String body,
      required String token,
      String? senderIdentity,
      String? appointmentId,
      required String notificationType}) async {
    Map<String, dynamic> map = {};
    if (senderIdentity != null) {
      map[ConstRes.senderId] = senderIdentity;
    }
    if (appointmentId != null) {
      map[ConstRes.bookingId] = appointmentId;
    }
    map[ConstRes.notificationType] = notificationType;
    await http.post(
      Uri.parse(ConstRes.pushNotificationToSingleUser),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
        'content-type': 'application/json'
      },
      body: json.encode(
        {
          'message': {
            'data': map,
            'notification': {
              'title': title,
              'body': body,
              // "sound": "default",
              // "badge": "1",
            },
            'token': token,
          }
        },
      ),
    );
  }

  Future<WalletStatement> fetchSalonWalletStatement(int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchWalletStatement),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return WalletStatement.fromJson(responseJson);
  }

  Future<Slot> fetchAvailableSlotsOfStaff(
      num salonId, num staffId, String date, num weekDay) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchAvailableSlotsOfStaff),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.salonId_: salonId.toString(),
        ConstRes.staffId: staffId.toString(),
        ConstRes.date: date,
        ConstRes.weekday: weekDay.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return Slot.fromJson(responseJson);
  }

  Future<RestResponse> submitUserWithdrawRequest({
    required String bankTitle,
    required String accountNumber,
    required String holder,
    required String swiftCode,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.submitUserWithdrawRequest),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.bankTitle: bankTitle,
        ConstRes.accountNumber: accountNumber,
        ConstRes.holder: holder,
        ConstRes.swiftCode: swiftCode,
      },
    );
    final responseJson = jsonDecode(response.body);
    await fetchMyUserDetails();
    return RestResponse.fromJson(responseJson);
  }

  Future<Faqs> fetchFaqCats() async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchFaqCats),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
    );
    final responseJson = jsonDecode(response.body);
    return Faqs.fromJson(responseJson);
  }

  var client = http.Client();

  Future<service.Services> searchServices({
    required String keyword,
    required int start,
    String? catId,
  }) async {
    client.close();
    client = http.Client();
    final response = await client.post(
      Uri.parse(ConstRes.searchServices),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: catId != null
          ? {
              ConstRes.keyword: keyword,
              ConstRes.categoryId: catId.toString(),
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            }
          : {
              ConstRes.keyword: keyword,
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            },
    );
    final responseJson = jsonDecode(response.body);
    return service.Services.fromJson(responseJson);
  }

  Future<SalonByCoordinates> searchSalon({
    required String keyword,
    required int start,
    String? catId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.searchSalon),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: catId != null
          ? {
              ConstRes.keyword: keyword,
              ConstRes.categoryId: catId,
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            }
          : {
              ConstRes.keyword: keyword,
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            },
    );
    final responseJson = jsonDecode(response.body);
    return SalonByCoordinates.fromJson(responseJson);
  }

  Future<SalonByCoordinates> searchTopRatedSalonsOfCategory({
    required String keyword,
    required int start,
    String? catId,
  }) async {
    final response = await http.post(
      Uri.parse(ConstRes.searchTopRatedSalonsOfCategory),
      headers: {
        ConstRes.apiKey: ConstRes.apiKeyValue,
      },
      body: catId != null
          ? {
              ConstRes.keyword: keyword.isEmpty ? " " : keyword,
              ConstRes.categoryId: catId,
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            }
          : {
              ConstRes.keyword: keyword,
              ConstRes.start: start.toString(),
              ConstRes.count: ConstRes.count_.toString(),
            },
    );
    final responseJson = jsonDecode(response.body);
    return SalonByCoordinates.fromJson(responseJson);
  }

  Future<MyNotification> fetchUserNotification(int start) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchUserNotification),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        // ConstRes.salonId_: ConstRes.userIdValue.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return MyNotification.fromJson(responseJson);
  }

  Future<RestResponse> deleteMyUserAccount() async {
    await deleteFirebaseUser();
    final response = await http.post(
      Uri.parse(ConstRes.deleteMyUserAccount),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
      },
    );

    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<void> deleteFirebaseUser() async {
    SharePref sharePref = await SharePref().init();
    UserData? userData = sharePref.getSalonUser()?.data;
    String userIdentity = '${FirebaseRes.ct}${'${userData?.identity}'}';
    String time = DateTime.now().millisecondsSinceEpoch.toString();

    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection(FirebaseRes.userChatList)
        .doc(userIdentity)
        .collection(FirebaseRes.userList)
        .get()
        .then((value) {
      for (var element in value.docs) {
        db
            .collection(FirebaseRes.userChatList)
            .doc(element.id)
            .collection(FirebaseRes.userList)
            .doc(userIdentity)
            .update({
          FirebaseRes.isDeleted: true,
          FirebaseRes.deletedId: time,
        });
        db
            .collection(FirebaseRes.userChatList)
            .doc(userIdentity)
            .collection(FirebaseRes.userList)
            .doc(element.id)
            .update({
          FirebaseRes.isDeleted: true,
          FirebaseRes.deletedId: time,
        });
      }
    });
    if (userData?.loginType?.toInt() == 3) {
      await FirebaseAuth.instance.currentUser
          ?.delete()
          .onError((error, stackTrace) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: userData?.identity ?? '',
                password: sharePref.getString(ConstRes.password) ?? '')
            .then((value) {
          FirebaseAuth.instance.currentUser?.delete().then((value) {});
        });
      });
    }
  }

  Future<WithdrawRequests> fetchUserWithdrawRequests(
      {required int start}) async {
    final response = await http.post(
      Uri.parse(ConstRes.fetchUserWithdrawRequests),
      headers: {ConstRes.apiKey: ConstRes.apiKeyValue},
      body: {
        ConstRes.userId: ConstRes.userIdValue.toString(),
        ConstRes.start: start.toString(),
        ConstRes.count: ConstRes.count_.toString(),
      },
    );
    final responseJson = jsonDecode(response.body);
    return WithdrawRequests.fromJson(responseJson);
  }

  Future<Staff> fetchAllStaffOfSalon({required int salonId}) async {
    var request = http.MultipartRequest(
      ConstRes.aPost,
      Uri.parse(ConstRes.fetchAllStaffOfSalon),
    );

    request.headers.addAll({ConstRes.apiKey: ConstRes.apiKeyValue});
    request.fields[ConstRes.salonId_] = salonId.toString();

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    return Staff.fromJson(responseJson);
  }
}
