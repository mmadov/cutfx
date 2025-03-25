import 'package:cutfx/model/coupon/coupon.dart';
import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/user/salon.dart';

class OrderSummary {
  OrderSummary({
    num? serviceAmount,
    num? discountAmount,
    num? subtotal,
    num? totalTaxAmount,
    num? payableAmount,
    num? couponApply,
    CouponData? coupon,
    List<Taxes>? taxes,
    List<Services>? services,
  }) {
    _serviceAmount = serviceAmount;
    _discountAmount = discountAmount;
    _subtotal = subtotal;
    _totalTaxAmount = totalTaxAmount;
    _payableAmount = payableAmount;
    _couponApply = couponApply;
    _coupon = coupon;
    _taxes = taxes;
    _services = services;
  }

  OrderSummary.fromJson(dynamic json) {
    _serviceAmount = json['service_amount'];
    _discountAmount = json['discount_amount'];
    _subtotal = json['subtotal'];
    _totalTaxAmount = json['total_tax_amount'];
    _payableAmount = json['payable_amount'];
    _couponApply = json['coupon_apply'];
    if (json['coupon'] != null) {
      _coupon =
          json['coupon'] != null ? CouponData.fromJson(json['coupon']) : null;
    }
    if (json['taxes'] != null) {
      _taxes = [];
      json['taxes'].forEach((v) {
        _taxes?.add(Taxes.fromJson(v));
      });
    }
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }

  num? _serviceAmount;
  num? _discountAmount;
  num? _subtotal;
  num? _totalTaxAmount;
  num? _payableAmount;
  num? _couponApply;
  CouponData? _coupon;
  List<Taxes>? _taxes;
  List<Services>? _services;

  OrderSummary copyWith({
    num? serviceAmount,
    num? discountAmount,
    num? subtotal,
    num? totalTaxAmount,
    num? payableAmount,
    num? couponApply,
    CouponData? coupon,
    List<Taxes>? taxes,
    List<Services>? services,
  }) =>
      OrderSummary(
        serviceAmount: serviceAmount ?? _serviceAmount,
        discountAmount: discountAmount ?? _discountAmount,
        subtotal: subtotal ?? _subtotal,
        totalTaxAmount: totalTaxAmount ?? _totalTaxAmount,
        payableAmount: payableAmount ?? _payableAmount,
        couponApply: couponApply ?? _couponApply,
        coupon: coupon ?? _coupon,
        taxes: taxes ?? _taxes,
        services: services ?? _services,
      );

  num? get serviceAmount => _serviceAmount;

  num? get discountAmount => _discountAmount;

  num? get subtotal => _subtotal;

  num? get totalTaxAmount => _totalTaxAmount;

  num? get payableAmount => _payableAmount;

  num? get couponApply => _couponApply;

  CouponData? get coupon => _coupon;

  List<Taxes>? get taxes => _taxes;

  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_amount'] = _serviceAmount;
    map['discount_amount'] = _discountAmount;
    map['subtotal'] = _subtotal;
    map['total_tax_amount'] = _totalTaxAmount;
    map['payable_amount'] = _payableAmount;
    map['coupon_apply'] = _couponApply;
    if (_coupon != null) {
      map['coupon'] = _coupon?.toJson();
    }
    if (_taxes != null) {
      map['taxes'] = _taxes?.map((v) => v.toJson()).toList();
    }
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
