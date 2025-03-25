class Coupon {
  Coupon({
    bool? status,
    String? message,
    List<CouponData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Coupon.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CouponData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<CouponData>? _data;

  Coupon copyWith({
    bool? status,
    String? message,
    List<CouponData>? data,
  }) =>
      Coupon(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<CouponData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CouponData {
  CouponData({
    num? id,
    String? coupon,
    num? percentage,
    num? maxDiscountAmount,
    num? minOrderAmount,
    String? heading,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _coupon = coupon;
    _percentage = percentage;
    _maxDiscountAmount = maxDiscountAmount;
    _minOrderAmount = minOrderAmount;
    _heading = heading;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CouponData.fromJson(dynamic json) {
    _id = json['id'];
    _coupon = json['coupon'];
    _percentage = json['percentage'];
    _maxDiscountAmount = json['max_discount_amount'];
    _minOrderAmount = json['min_order_amount'];
    _heading = json['heading'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _coupon;
  num? _percentage;
  num? _maxDiscountAmount;
  num? _minOrderAmount;
  String? _heading;
  String? _description;
  String? _createdAt;
  String? _updatedAt;

  CouponData copyWith({
    num? id,
    String? coupon,
    num? percentage,
    num? maxDiscountAmount,
    num? minOrderAmount,
    String? heading,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      CouponData(
        id: id ?? _id,
        coupon: coupon ?? _coupon,
        percentage: percentage ?? _percentage,
        maxDiscountAmount: maxDiscountAmount ?? _maxDiscountAmount,
        minOrderAmount: minOrderAmount ?? _minOrderAmount,
        heading: heading ?? _heading,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get coupon => _coupon;

  num? get percentage => _percentage;

  num? get maxDiscountAmount => _maxDiscountAmount;

  num? get minOrderAmount => _minOrderAmount;

  String? get heading => _heading;

  String? get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupon'] = _coupon;
    map['percentage'] = _percentage;
    map['max_discount_amount'] = _maxDiscountAmount;
    map['min_order_amount'] = _minOrderAmount;
    map['heading'] = _heading;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
