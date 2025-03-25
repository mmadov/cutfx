class Slot {
  Slot({
    bool? status,
    String? message,
    List<SlotData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Slot.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SlotData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SlotData>? _data;
  Slot copyWith({
    bool? status,
    String? message,
    List<SlotData>? data,
  }) =>
      Slot(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<SlotData>? get data => _data;

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

class SlotData {
  SlotData({
    num? id,
    num? staffId,
    String? time,
    num? weekday,
    String? createdAt,
    String? updatedAt,
    bool? available,
  }) {
    _id = id;
    _staffId = staffId;
    _time = time;
    _weekday = weekday;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _available = available;
  }

  SlotData.fromJson(dynamic json) {
    _id = json['id'];
    _staffId = json['staff_id'];
    _time = json['time'];
    _weekday = json['weekday'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _available = json['available'];
  }
  num? _id;
  num? _staffId;
  String? _time;
  num? _weekday;
  String? _createdAt;
  String? _updatedAt;
  bool? _available;
  SlotData copyWith({
    num? id,
    num? staffId,
    String? time,
    num? weekday,
    String? createdAt,
    String? updatedAt,
    bool? available,
  }) =>
      SlotData(
        id: id ?? _id,
        staffId: staffId ?? _staffId,
        time: time ?? _time,
        weekday: weekday ?? _weekday,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        available: available ?? _available,
      );
  num? get id => _id;

  num? get staffId => _staffId;
  String? get time => _time;
  num? get weekday => _weekday;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  bool? get available => _available;

  // calculateBookingLimit(int totalBookings) {
  //   remainSlot = (bookingLimit ?? 0) - totalBookings;
  // }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['staff_id'] = _staffId;
    map['time'] = _time;
    map['weekday'] = _weekday;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['available'] = _available;
    return map;
  }
}
