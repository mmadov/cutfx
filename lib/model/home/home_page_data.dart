import 'package:cutfx/model/user/salon.dart';

class HomePageData {
  HomePageData({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  HomePageData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  HomePageData copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      HomePageData(
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
    List<Categories>? categories,
    List<SalonData>? topRatedSalons,
    List<CategoriesWithService>? categoriesWithService,
  }) {
    _banners = banners;
    _categories = categories;
    _topRatedSalons = topRatedSalons;
    _categoriesWithService = categoriesWithService;
  }

  Data.fromJson(dynamic json) {
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['topRatedSalons'] != null) {
      _topRatedSalons = [];
      json['topRatedSalons'].forEach((v) {
        _topRatedSalons?.add(SalonData.fromJson(v));
      });
    }
    if (json['categoriesWithService'] != null) {
      _categoriesWithService = [];
      json['categoriesWithService'].forEach((v) {
        _categoriesWithService?.add(CategoriesWithService.fromJson(v));
      });
    }
  }

  List<Banners>? _banners;
  List<Categories>? _categories;
  List<SalonData>? _topRatedSalons;
  List<CategoriesWithService>? _categoriesWithService;

  Data copyWith({
    List<Banners>? banners,
    List<Categories>? categories,
    List<SalonData>? topRatedSalons,
    List<CategoriesWithService>? categoriesWithService,
  }) =>
      Data(
        banners: banners ?? _banners,
        categories: categories ?? _categories,
        topRatedSalons: topRatedSalons ?? _topRatedSalons,
        categoriesWithService: categoriesWithService ?? _categoriesWithService,
      );

  List<Banners>? get banners => _banners;

  List<Categories>? get categories => _categories;

  List<SalonData>? get topRatedSalons => _topRatedSalons;

  List<CategoriesWithService>? get categoriesWithService =>
      _categoriesWithService;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_topRatedSalons != null) {
      map['topRatedSalons'] = _topRatedSalons?.map((v) => v.toJson()).toList();
    }
    if (_categoriesWithService != null) {
      map['categoriesWithService'] =
          _categoriesWithService?.map((v) => v.toJson()).toList();
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

class Services {
  Services({
    num? id,
    num? status,
    String? serviceNumber,
    num? categoryId,
    num? salonId,
    String? title,
    num? serviceTime,
    num? price,
    num? discount,
    num? gender,
    List<ServiceImages>? images,
    String? about,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _status = status;
    _serviceNumber = serviceNumber;
    _categoryId = categoryId;
    _salonId = salonId;
    _title = title;
    _serviceTime = serviceTime;
    _price = price;
    _discount = discount;
    _gender = gender;
    _images = images;
    _about = about;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _serviceNumber = json['service_number'];
    _categoryId = json['category_id'];
    _salonId = json['salon_id'];
    _title = json['title'];
    _serviceTime = json['service_time'];
    _price = json['price'];
    _discount = json['discount'];
    _gender = json['gender'];
    _about = json['about'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(ServiceImages.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _status;
  String? _serviceNumber;
  num? _categoryId;
  num? _salonId;
  String? _title;
  num? _serviceTime;
  num? _price;
  num? _discount;
  num? _gender;
  List<ServiceImages>? _images;
  String? _about;
  String? _createdAt;
  String? _updatedAt;

  Services copyWith({
    num? id,
    num? status,
    String? serviceNumber,
    num? categoryId,
    num? salonId,
    String? title,
    num? serviceTime,
    num? price,
    num? discount,
    num? gender,
    String? about,
    List<ServiceImages>? images,
    String? createdAt,
    String? updatedAt,
  }) =>
      Services(
        id: id ?? _id,
        status: status ?? _status,
        serviceNumber: serviceNumber ?? _serviceNumber,
        categoryId: categoryId ?? _categoryId,
        salonId: salonId ?? _salonId,
        title: title ?? _title,
        serviceTime: serviceTime ?? _serviceTime,
        price: price ?? _price,
        discount: discount ?? _discount,
        gender: gender ?? _gender,
        about: about ?? _about,
        images: images ?? _images,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get status => _status;

  String? get serviceNumber => _serviceNumber;

  num? get categoryId => _categoryId;

  num? get salonId => _salonId;

  String? get title => _title;

  num? get serviceTime => _serviceTime;

  num? get price => _price;

  num? get discount => _discount;

  num? get gender => _gender;

  List<ServiceImages>? get images => _images;

  String? get about => _about;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['service_number'] = _serviceNumber;
    map['category_id'] = _categoryId;
    map['salon_id'] = _salonId;
    map['title'] = _title;
    map['service_time'] = _serviceTime;
    map['price'] = _price;
    map['discount'] = _discount;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['gender'] = _gender;
    map['about'] = _about;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
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
