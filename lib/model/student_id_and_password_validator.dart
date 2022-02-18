/// is_success : true
/// message : "Successfully Login"
/// student_info : {"id":"1","name":"Sazzadur Rahman","name_bangla":"Sazzadur Rahman","student_code":"211001","date_of_birth":null,"gender":"M","father_name":"Abdul Kader","mother_name":"Shaheda Parvin","guardian_mobile":"01711040536","photo":null}
/// contact_info : {"id":"3","institute_type":"1","school_name":"NEW SCHOOL","school_name_bangla":"NEW SCHOOL","school_short_name":"200009","eiin_number":"1","address":"ADDRESS","address_bangla":"ADDRESS","email":"-","mobile":"0","facebook_address":"-","web_address":"http://school360.app/200009","picture":"contact_1641833188_2022-01-10.png","use_timekeeping":"0","login_page_image_added":"0"}

class StudentIdAndPasswordValidator {
  StudentIdAndPasswordValidator({
      bool? isSuccess, 
      String? message, 
      StudentInfo? studentInfo, 
      ContactInfo? contactInfo,}){
    _isSuccess = isSuccess;
    _message = message;
    _studentInfo = studentInfo;
    _contactInfo = contactInfo;
}

  StudentIdAndPasswordValidator.fromJson(dynamic json) {
    _isSuccess = json['is_success'];
    _message = json['message'];
    _studentInfo = json['student_info'] != null ? StudentInfo.fromJson(json['student_info']) : null;
    _contactInfo = json['contact_info'] != null ? ContactInfo.fromJson(json['contact_info']) : null;
  }
  bool? _isSuccess;
  String? _message;
  StudentInfo? _studentInfo;
  ContactInfo? _contactInfo;

  bool? get isSuccess => _isSuccess;
  String? get message => _message;
  StudentInfo? get studentInfo => _studentInfo;
  ContactInfo? get contactInfo => _contactInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_success'] = _isSuccess;
    map['message'] = _message;
    if (_studentInfo != null) {
      map['student_info'] = _studentInfo?.toJson();
    }
    if (_contactInfo != null) {
      map['contact_info'] = _contactInfo?.toJson();
    }
    return map;
  }

}

/// id : "3"
/// institute_type : "1"
/// school_name : "NEW SCHOOL"
/// school_name_bangla : "NEW SCHOOL"
/// school_short_name : "200009"
/// eiin_number : "1"
/// address : "ADDRESS"
/// address_bangla : "ADDRESS"
/// email : "-"
/// mobile : "0"
/// facebook_address : "-"
/// web_address : "http://school360.app/200009"
/// picture : "contact_1641833188_2022-01-10.png"
/// use_timekeeping : "0"
/// login_page_image_added : "0"

class ContactInfo {
  ContactInfo({
      String? id, 
      String? instituteType, 
      String? schoolName, 
      String? schoolNameBangla, 
      String? schoolShortName, 
      String? eiinNumber, 
      String? address, 
      String? addressBangla, 
      String? email, 
      String? mobile, 
      String? facebookAddress, 
      String? webAddress, 
      String? picture, 
      String? useTimekeeping, 
      String? loginPageImageAdded,}){
    _id = id;
    _instituteType = instituteType;
    _schoolName = schoolName;
    _schoolNameBangla = schoolNameBangla;
    _schoolShortName = schoolShortName;
    _eiinNumber = eiinNumber;
    _address = address;
    _addressBangla = addressBangla;
    _email = email;
    _mobile = mobile;
    _facebookAddress = facebookAddress;
    _webAddress = webAddress;
    _picture = picture;
    _useTimekeeping = useTimekeeping;
    _loginPageImageAdded = loginPageImageAdded;
}

  ContactInfo.fromJson(dynamic json) {
    _id = json['id'];
    _instituteType = json['institute_type'];
    _schoolName = json['school_name'];
    _schoolNameBangla = json['school_name_bangla'];
    _schoolShortName = json['school_short_name'];
    _eiinNumber = json['eiin_number'];
    _address = json['address'];
    _addressBangla = json['address_bangla'];
    _email = json['email'];
    _mobile = json['mobile'];
    _facebookAddress = json['facebook_address'];
    _webAddress = json['web_address'];
    _picture = json['picture'];
    _useTimekeeping = json['use_timekeeping'];
    _loginPageImageAdded = json['login_page_image_added'];
  }
  String? _id;
  String? _instituteType;
  String? _schoolName;
  String? _schoolNameBangla;
  String? _schoolShortName;
  String? _eiinNumber;
  String? _address;
  String? _addressBangla;
  String? _email;
  String? _mobile;
  String? _facebookAddress;
  String? _webAddress;
  String? _picture;
  String? _useTimekeeping;
  String? _loginPageImageAdded;

  String? get id => _id;
  String? get instituteType => _instituteType;
  String? get schoolName => _schoolName;
  String? get schoolNameBangla => _schoolNameBangla;
  String? get schoolShortName => _schoolShortName;
  String? get eiinNumber => _eiinNumber;
  String? get address => _address;
  String? get addressBangla => _addressBangla;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get facebookAddress => _facebookAddress;
  String? get webAddress => _webAddress;
  String? get picture => _picture;
  String? get useTimekeeping => _useTimekeeping;
  String? get loginPageImageAdded => _loginPageImageAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['institute_type'] = _instituteType;
    map['school_name'] = _schoolName;
    map['school_name_bangla'] = _schoolNameBangla;
    map['school_short_name'] = _schoolShortName;
    map['eiin_number'] = _eiinNumber;
    map['address'] = _address;
    map['address_bangla'] = _addressBangla;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['facebook_address'] = _facebookAddress;
    map['web_address'] = _webAddress;
    map['picture'] = _picture;
    map['use_timekeeping'] = _useTimekeeping;
    map['login_page_image_added'] = _loginPageImageAdded;
    return map;
  }

}

/// id : "1"
/// name : "Sazzadur Rahman"
/// name_bangla : "Sazzadur Rahman"
/// student_code : "211001"
/// date_of_birth : null
/// gender : "M"
/// father_name : "Abdul Kader"
/// mother_name : "Shaheda Parvin"
/// guardian_mobile : "01711040536"
/// photo : null

class StudentInfo {
  StudentInfo({
      String? id, 
      String? name, 
      String? nameBangla, 
      String? studentCode, 
      dynamic dateOfBirth, 
      String? gender, 
      String? fatherName, 
      String? motherName, 
      String? guardianMobile, 
      dynamic photo,}){
    _id = id;
    _name = name;
    _nameBangla = nameBangla;
    _studentCode = studentCode;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _fatherName = fatherName;
    _motherName = motherName;
    _guardianMobile = guardianMobile;
    _photo = photo;
}

  StudentInfo.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameBangla = json['name_bangla'];
    _studentCode = json['student_code'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _fatherName = json['father_name'];
    _motherName = json['mother_name'];
    _guardianMobile = json['guardian_mobile'];
    _photo = json['photo'];
  }
  String? _id;
  String? _name;
  String? _nameBangla;
  String? _studentCode;
  dynamic _dateOfBirth;
  String? _gender;
  String? _fatherName;
  String? _motherName;
  String? _guardianMobile;
  dynamic _photo;

  String? get id => _id;
  String? get name => _name;
  String? get nameBangla => _nameBangla;
  String? get studentCode => _studentCode;
  dynamic get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get fatherName => _fatherName;
  String? get motherName => _motherName;
  String? get guardianMobile => _guardianMobile;
  dynamic get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['name_bangla'] = _nameBangla;
    map['student_code'] = _studentCode;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['father_name'] = _fatherName;
    map['mother_name'] = _motherName;
    map['guardian_mobile'] = _guardianMobile;
    map['photo'] = _photo;
    return map;
  }

}