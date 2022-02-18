/// is_success : true
/// status : "success"
/// message : "Institute found"
/// data : {"name":"School360 Demo School","address":"ADDRESS","url":"https://school360.app/demo/"}

class SchoolValidatorForLogInWithIdAndPassword {
  SchoolValidatorForLogInWithIdAndPassword({
      bool? isSuccess, 
      String? status, 
      String? message, 
      Data? data,}){
    _isSuccess = isSuccess;
    _status = status;
    _message = message;
    _data = data;
}

  SchoolValidatorForLogInWithIdAndPassword.fromJson(dynamic json) {
    _isSuccess = json['is_success'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _isSuccess;
  String? _status;
  String? _message;
  Data? _data;

  bool? get isSuccess => _isSuccess;
  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_success'] = _isSuccess;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// name : "School360 Demo School"
/// address : "ADDRESS"
/// url : "https://school360.app/demo/"

class Data {
  Data({
      String? name, 
      String? address, 
      String? url,}){
    _name = name;
    _address = address;
    _url = url;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _address = json['address'];
    _url = json['url'];
  }
  String? _name;
  String? _address;
  String? _url;

  String? get name => _name;
  String? get address => _address;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['address'] = _address;
    map['url'] = _url;
    return map;
  }

}