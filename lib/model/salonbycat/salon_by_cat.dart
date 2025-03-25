import 'package:cutfx/model/user/salon.dart';

class SalonByCat {
  SalonByCat({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SalonByCat.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  SalonByCat copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      SalonByCat(
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
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<Banners>? banners,
    List<SalonData>? topRatedSalons,
    List<Services>? services,
  }) {
    _topRatedSalons = topRatedSalons;
    _services = services;
  }

  Data.fromJson(dynamic json) {
    if (json['topRatedSalons'] != null) {
      _topRatedSalons = [];
      json['topRatedSalons'].forEach((v) {
        _topRatedSalons?.add(SalonData.fromJson(v));
      });
    }
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }

  List<SalonData>? _topRatedSalons;
  List<Services>? _services;

  Data copyWith({
    List<SalonData>? topRatedSalons,
    List<Services>? services,
  }) =>
      Data(
        topRatedSalons: topRatedSalons ?? _topRatedSalons,
        services: services ?? _services,
      );

  List<SalonData>? get topRatedSalons => _topRatedSalons;

  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_topRatedSalons != null) {
      map['topRatedSalons'] = _topRatedSalons?.map((v) => v.toJson()).toList();
    }
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoriesWithService {
  CategoriesWithService({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    List<Services>? services,
  }) {
    _id = id;
    _title = title;
    _icon = icon;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _services = services;
  }

  CategoriesWithService.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _icon = json['icon'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }

  num? _id;
  String? _title;
  String? _icon;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  List<Services>? _services;

  CategoriesWithService copyWith({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
    List<Services>? services,
  }) =>
      CategoriesWithService(
        id: id ?? _id,
        title: title ?? _title,
        icon: icon ?? _icon,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        services: services ?? _services,
      );

  num? get id => _id;

  String? get title => _title;

  String? get icon => _icon;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['icon'] = _icon;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categories {
  Categories({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _icon = icon;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _icon = json['icon'];
    _isDeleted = json['is_deleted'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _title;
  String? _icon;
  num? _isDeleted;
  String? _createdAt;
  String? _updatedAt;

  Categories copyWith({
    num? id,
    String? title,
    String? icon,
    num? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) =>
      Categories(
        id: id ?? _id,
        title: title ?? _title,
        icon: icon ?? _icon,
        isDeleted: isDeleted ?? _isDeleted,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get title => _title;

  String? get icon => _icon;

  num? get isDeleted => _isDeleted;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['icon'] = _icon;
    map['is_deleted'] = _isDeleted;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Banners {
  Banners({
    num? id,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Banners copyWith({
    num? id,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Banners(
        id: id ?? _id,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Images {
  Images({
    int? id,
    int? salonId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _salonId = salonId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _salonId = json['salon_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _salonId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  Images copyWith({
    int? id,
    int? salonId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? _id,
        salonId: salonId ?? _salonId,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  int? get salonId => _salonId;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['salon_id'] = _salonId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class ServiceImages {
  ServiceImages({
    int? id,
    int? salonId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _serviceId = salonId;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ServiceImages.fromJson(dynamic json) {
    _id = json['id'];
    _serviceId = json['service_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _serviceId;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  ServiceImages copyWith({
    int? id,
    int? serviceId,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      ServiceImages(
        id: id ?? _id,
        salonId: serviceId ?? _serviceId,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  int? get salonId => _serviceId;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['service_id'] = _serviceId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
