class Staff {
  Staff({
    bool? status,
    String? message,
    List<StaffData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Staff.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StaffData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<StaffData>? _data;

  Staff copyWith({
    bool? status,
    String? message,
    List<StaffData>? data,
  }) =>
      Staff(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<StaffData>? get data => _data;

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

class StaffData {
  StaffData({
    num? id,
    num? salonId,
    num? status,
    num? rating,
    String? photo,
    String? name,
    String? phone,
    num? gender,
    num? bookingsCount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _status = status;
    _rating = rating;
    _photo = photo;
    _name = name;
    _phone = phone;
    _gender = gender;
    _bookingsCount = bookingsCount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  StaffData.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _status = json['status'];
    _rating = json['rating'];
    _photo = json['photo'];
    _name = json['name'];
    _phone = json['phone'];
    _gender = json['gender'];
    _bookingsCount = json['bookings_count'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _salonId;
  num? _status;
  num? _rating;
  String? _photo;
  String? _name;
  String? _phone;
  num? _gender;
  num? _bookingsCount;
  String? _createdAt;
  String? _updatedAt;

  StaffData copyWith({
    num? id,
    num? salonId,
    num? status,
    num? rating,
    String? photo,
    String? name,
    String? phone,
    num? gender,
    num? bookingsCount,
    String? createdAt,
    String? updatedAt,
  }) =>
      StaffData(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        status: status ?? _status,
        rating: rating ?? _rating,
        photo: photo ?? _photo,
        name: name ?? _name,
        phone: phone ?? _phone,
        gender: gender ?? _gender,
        bookingsCount: bookingsCount ?? _bookingsCount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get salonId => _salonId;

  num? get status => _status;

  num? get rating => _rating;

  String? get photo => _photo;

  String? get name => _name;

  String? get phone => _phone;

  num? get gender => _gender;

  num? get bookingsCount => _bookingsCount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['status'] = _status;
    map['rating'] = _rating;
    map['photo'] = _photo;
    map['name'] = _name;
    map['phone'] = _phone;
    map['gender'] = _gender;
    map['bookings_count'] = _bookingsCount;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
