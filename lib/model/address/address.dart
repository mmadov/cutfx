class Address {
  Address({
    bool? status,
    String? message,
    List<AddressData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Address.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AddressData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<AddressData>? _data;

  Address copyWith({
    bool? status,
    String? message,
    List<AddressData>? data,
  }) =>
      Address(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<AddressData>? get data => _data;

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

class AddressData {
  AddressData({
    num? id,
    num? userId,
    String? name,
    String? mobile,
    String? address,
    String? locality,
    String? city,
    String? pin,
    String? state,
    String? country,
    num? type,
    dynamic latitude,
    dynamic longitude,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _mobile = mobile;
    _address = address;
    _locality = locality;
    _city = city;
    _pin = pin;
    _state = state;
    _country = country;
    _type = type;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AddressData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _address = json['address'];
    _locality = json['locality'];
    _city = json['city'];
    _pin = json['pin'];
    _state = json['state'];
    _country = json['country'];
    _type = json['type'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _userId;
  String? _name;
  String? _mobile;
  String? _address;
  String? _locality;
  String? _city;
  String? _pin;
  String? _state;
  String? _country;
  num? _type;
  dynamic _latitude;
  dynamic _longitude;
  String? _createdAt;
  String? _updatedAt;

  AddressData copyWith({
    num? id,
    num? userId,
    String? name,
    String? mobile,
    String? address,
    String? locality,
    String? city,
    String? pin,
    String? state,
    String? country,
    num? type,
    dynamic latitude,
    dynamic longitude,
    String? createdAt,
    String? updatedAt,
  }) =>
      AddressData(
        id: id ?? _id,
        userId: userId ?? _userId,
        name: name ?? _name,
        mobile: mobile ?? _mobile,
        address: address ?? _address,
        locality: locality ?? _locality,
        city: city ?? _city,
        pin: pin ?? _pin,
        state: state ?? _state,
        country: country ?? _country,
        type: type ?? _type,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get userId => _userId;

  String? get name => _name;

  String? get mobile => _mobile;

  String? get address =>
      '${_address ?? ''}, ${locality ?? ''}, ${city ?? ''}, ${state ?? ''}, ${country ?? ''}, ${pin ?? ''}';

  String? get onlyAddress => _address;

  String? get locality => _locality;

  String? get city => _city;

  String? get pin => _pin;

  String? get state => _state;

  String? get country => _country;

  num? get type => _type;

  dynamic get latitude => _latitude;

  dynamic get longitude => _longitude;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['locality'] = _locality;
    map['city'] = _city;
    map['pin'] = _pin;
    map['state'] = _state;
    map['country'] = _country;
    map['type'] = _type;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
