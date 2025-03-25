import 'package:cutfx/model/user/salon.dart';

class FavouriteData {
  FavouriteData({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FavouriteData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = Data.fromJson(json['data']);
    }
  }

  bool? _status;
  String? _message;
  Data? _data;

  FavouriteData copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FavouriteData(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;

    map['data'] = _data?.toJson();

    return map;
  }
}

class Data {
  Data({
    List<Services>? services,
    List<SalonData>? salons,
  }) {
    _services = services;
    _salons = salons;
  }

  Data.fromJson(dynamic json) {
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
    if (json['salons'] != null) {
      _salons = [];
      json['salons'].forEach((v) {
        _salons?.add(SalonData.fromJson(v));
      });
    }
  }

  List<Services>? _services;
  List<SalonData>? _salons;

  Data copyWith({
    List<Services>? services,
    List<SalonData>? salons,
  }) =>
      Data(
        services: services ?? _services,
        salons: salons ?? _salons,
      );

  List<Services>? get services => _services;

  List<SalonData>? get salons => _salons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    if (_salons != null) {
      map['salons'] = _salons?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
