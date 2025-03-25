import 'package:cutfx/model/service/services.dart';

class ServiceDetails {
  ServiceDetails({
    bool? status,
    String? message,
    ServiceData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ServiceDetails.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = ServiceData.fromJson(json['data']);
    }
  }

  bool? _status;
  String? _message;
  ServiceData? _data;

  ServiceDetails copyWith({
    bool? status,
    String? message,
    ServiceData? data,
  }) =>
      ServiceDetails(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  ServiceData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data?.toJson();
    return map;
  }
}
