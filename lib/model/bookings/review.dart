class Review {
  Review({
    num? id,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rating,
    String? comment,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _salonId = salonId;
    _bookingId = bookingId;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Review.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _salonId = json['salon_id'];
    _bookingId = json['booking_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _id;
  num? _userId;
  num? _salonId;
  num? _bookingId;
  num? _rating;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;

  Review copyWith({
    num? id,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rating,
    String? comment,
    String? createdAt,
    String? updatedAt,
  }) =>
      Review(
        id: id ?? _id,
        userId: userId ?? _userId,
        salonId: salonId ?? _salonId,
        bookingId: bookingId ?? _bookingId,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get salonId => _salonId;

  num? get bookingId => _bookingId;

  num? get rating => _rating;

  String? get comment => _comment;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['salon_id'] = _salonId;
    map['booking_id'] = _bookingId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
