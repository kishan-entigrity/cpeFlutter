/// user_type : [{"id":1,"title":"Accountant/Bookkeeper (ACCT./BK)","short_title":"ACCT_BK","home_page":"0","signup_form":"1","status":"active"},{"id":2,"title":"Accredited Financial Examiner (AFE)","short_title":"AFE","home_page":"0","signup_form":"1","status":"active"}]

class Profcreds_list {
  List<User_type> _userType;

  List<User_type> get userType => _userType;

  Profcreds_list({List<User_type> userType}) {
    _userType = userType;
  }

  Profcreds_list.fromJson(dynamic json) {
    if (json["user_type"] != null) {
      _userType = [];
      json["user_type"].forEach((v) {
        _userType.add(User_type.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_userType != null) {
      map["user_type"] = _userType.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// title : "Accountant/Bookkeeper (ACCT./BK)"
/// short_title : "ACCT_BK"
/// home_page : "0"
/// signup_form : "1"
/// status : "active"

class User_type {
  int _id;
  String _title;
  String _shortTitle;
  String _homePage;
  String _signupForm;
  String _status;

  int get id => _id;
  String get title => _title;
  String get shortTitle => _shortTitle;
  String get homePage => _homePage;
  String get signupForm => _signupForm;
  String get status => _status;

  User_type({int id, String title, String shortTitle, String homePage, String signupForm, String status}) {
    _id = id;
    _title = title;
    _shortTitle = shortTitle;
    _homePage = homePage;
    _signupForm = signupForm;
    _status = status;
  }

  User_type.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _shortTitle = json["short_title"];
    _homePage = json["home_page"];
    _signupForm = json["signup_form"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["short_title"] = _shortTitle;
    map["home_page"] = _homePage;
    map["signup_form"] = _signupForm;
    map["status"] = _status;
    return map;
  }
}
