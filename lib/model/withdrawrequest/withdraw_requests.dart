class WithdrawRequests {
  WithdrawRequests({
    bool? status,
    String? message,
    List<WithdrawRequestsData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  WithdrawRequests.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WithdrawRequestsData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<WithdrawRequestsData>? _data;
  WithdrawRequests copyWith({
    bool? status,
    String? message,
    List<WithdrawRequestsData>? data,
  }) =>
      WithdrawRequests(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<WithdrawRequestsData>? get data => _data;

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

class WithdrawRequestsData {
  WithdrawRequestsData({
    num? id,
    String? requestNumber,
    num? userId,
    num? status,
    num? amount,
    String? bankTitle,
    String? accountNumber,
    String? holder,
    String? swiftCode,
    dynamic summary,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _requestNumber = requestNumber;
    _userId = userId;
    _status = status;
    _amount = amount;
    _bankTitle = bankTitle;
    _accountNumber = accountNumber;
    _holder = holder;
    _swiftCode = swiftCode;
    _summary = summary;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  WithdrawRequestsData.fromJson(dynamic json) {
    _id = json['id'];
    _requestNumber = json['request_number'];
    _userId = json['user_id'];
    _status = json['status'];
    _amount = json['amount'];
    _bankTitle = json['bank_title'];
    _accountNumber = json['account_number'];
    _holder = json['holder'];
    _swiftCode = json['swift_code'];
    _summary = json['summary'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _requestNumber;
  num? _userId;
  num? _status;
  num? _amount;
  String? _bankTitle;
  String? _accountNumber;
  String? _holder;
  String? _swiftCode;
  dynamic _summary;
  String? _createdAt;
  String? _updatedAt;
  WithdrawRequestsData copyWith({
    num? id,
    String? requestNumber,
    num? userId,
    num? status,
    num? amount,
    String? bankTitle,
    String? accountNumber,
    String? holder,
    String? swiftCode,
    dynamic summary,
    String? createdAt,
    String? updatedAt,
  }) =>
      WithdrawRequestsData(
        id: id ?? _id,
        requestNumber: requestNumber ?? _requestNumber,
        userId: userId ?? _userId,
        status: status ?? _status,
        amount: amount ?? _amount,
        bankTitle: bankTitle ?? _bankTitle,
        accountNumber: accountNumber ?? _accountNumber,
        holder: holder ?? _holder,
        swiftCode: swiftCode ?? _swiftCode,
        summary: summary ?? _summary,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get requestNumber => _requestNumber;
  num? get userId => _userId;
  num? get status => _status;
  num? get amount => _amount;
  String? get bankTitle => _bankTitle;
  String? get accountNumber => _accountNumber;
  String? get holder => _holder;
  String? get swiftCode => _swiftCode;
  dynamic get summary => _summary;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['request_number'] = _requestNumber;
    map['user_id'] = _userId;
    map['status'] = _status;
    map['amount'] = _amount;
    map['bank_title'] = _bankTitle;
    map['account_number'] = _accountNumber;
    map['holder'] = _holder;
    map['swift_code'] = _swiftCode;
    map['summary'] = _summary;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
