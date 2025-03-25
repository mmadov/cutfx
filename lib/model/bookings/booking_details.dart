import 'package:cutfx/model/bookings/booking.dart';

/// status : true
/// message : "Data fetched successfully"
/// data : [{"id":9,"status":1,"booking_id":"SRU682471RJH","completion_otp":8585,"salon_id":2,"user_id":2,"date":"2023-03-15","time":"0940","duration":"2 Hours","services":"Services","is_coupon_applied":1,"coupon_title":"COUPON25","discount_amount":10,"total_amount":25,"payable_amount":15,"is_rated":1,"created_at":"2022-11-30T11:44:19.000000Z","updated_at":"2022-12-01T11:22:05.000000Z","user":{"id":2,"is_block":0,"identity":"pkotadiya04@gmail.com","fullname":"Parth Patel","email":null,"phone_number":null,"profile_image":"uploads/user.JPG","is_notification":1,"device_type":2,"device_token":"device_token2","login_type":2,"wallet":565,"favourite_salons":"1,2,3","favourite_services":"1,2,3","coupons_used":",1,2,2","created_at":"2022-11-25T07:27:09.000000Z","updated_at":"2023-03-03T12:14:56.000000Z"}}]

class BookingDetails {
  BookingDetails({
    bool? status,
    String? message,
    BookingData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  BookingDetails.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = BookingData.fromJson(json['data']);
    }
  }

  bool? _status;
  String? _message;
  BookingData? _data;

  BookingDetails copyWith({
    bool? status,
    String? message,
    BookingData? data,
  }) =>
      BookingDetails(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  BookingData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
