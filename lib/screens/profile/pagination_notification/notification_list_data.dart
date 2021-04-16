/// notification_list : [{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"STRUCTURING UNITED STATES INVESTMENTS BY FOREIGN TAXPAYERS\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1612965617,"is_read":0,"webinar_flag":2,"webinar_id":6122,"webinar_type":"LIVE","notification_title":"STRUCTURING UNITED STATES INVESTMENTS BY FOREIGN TAXPAYERS","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"Debt Forgiveness and Section 108\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1612965606,"is_read":0,"webinar_flag":2,"webinar_id":6147,"webinar_type":"LIVE","notification_title":"Debt Forgiveness and Section 108","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"PPP UPDATES WITH LATEST GUIDANCE FROM SBA, IRS & FORM 3508, FORM 3508-EZ, 3508-S\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1612540853,"is_read":0,"webinar_flag":2,"webinar_id":6224,"webinar_type":"LIVE","notification_title":"PPP UPDATES WITH LATEST GUIDANCE FROM SBA, IRS & FORM 3508, FORM 3508-EZ, 3508-S","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"THE 101 ON NOT-FOR-PROFIT\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1612449050,"is_read":0,"webinar_flag":2,"webinar_id":5945,"webinar_type":"LIVE","notification_title":"THE 101 ON NOT-FOR-PROFIT","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"12 Powerful Tax Saving Strategies for Your Small Business Owner Clients\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1607358643,"is_read":0,"webinar_flag":2,"webinar_id":4782,"webinar_type":"LIVE","notification_title":"12 Powerful Tax Saving Strategies for Your Small Business Owner Clients","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"12 Powerful Tax Saving Strategies for Your Small Business Owner Clients\" is scheduled on Dec 07, 2020 | 12:00 PM EST.","timestamp":1607187619,"is_read":0,"webinar_flag":2,"webinar_id":4782,"webinar_type":"LIVE","notification_title":"12 Powerful Tax Saving Strategies for Your Small Business Owner Clients","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"Excel Speed Loop: Systematically Improve Efficiency and Accuracy (For Bookkeepers, Accountants, Tax Pros, Auditors, CPAs)\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1606836699,"is_read":0,"webinar_flag":2,"webinar_id":3642,"webinar_type":"LIVE","notification_title":"Excel Speed Loop: Systematically Improve Efficiency and Accuracy (For Bookkeepers, Accountants, Tax Pros, Auditors, CPAs)","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"BEYOND WORKING REMOTELY – CASE STUDIES | BENEFITS | CHALLENGES FOR ACCOUNTING & TAX FIRMS\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1604068205,"is_read":0,"webinar_flag":2,"webinar_id":3311,"webinar_type":"LIVE","notification_title":"BEYOND WORKING REMOTELY – CASE STUDIES | BENEFITS | CHALLENGES FOR ACCOUNTING & TAX FIRMS","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"Key Estate Planning Considerations\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time.","timestamp":1603999804,"is_read":0,"webinar_flag":2,"webinar_id":2390,"webinar_type":"LIVE","notification_title":"Key Estate Planning Considerations","notification_type":"webinar"},{"image":"https://picsum.photos/200/300","notification_message":"Your webinar \"BEYOND WORKING REMOTELY – CASE STUDIES | BENEFITS | CHALLENGES FOR ACCOUNTING & TAX FIRMS\" is scheduled on Oct 30, 2020 | 11:00 AM EDT.","timestamp":1603897206,"is_read":0,"webinar_flag":2,"webinar_id":3311,"webinar_type":"LIVE","notification_title":"BEYOND WORKING REMOTELY – CASE STUDIES | BENEFITS | CHALLENGES FOR ACCOUNTING & TAX FIRMS","notification_type":"webinar"}]

class Notification_list_data {
  List<Notification_list> _notificationList;

  List<Notification_list> get notificationList => _notificationList;

  Notification_list_data({List<Notification_list> notificationList}) {
    _notificationList = notificationList;
  }

  Notification_list_data.fromJson(dynamic json) {
    if (json["notification_list"] != null) {
      _notificationList = [];
      json["notification_list"].forEach((v) {
        _notificationList.add(Notification_list.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_notificationList != null) {
      map["notification_list"] = _notificationList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// image : "https://picsum.photos/200/300"
/// notification_message : "Your webinar \"STRUCTURING UNITED STATES INVESTMENTS BY FOREIGN TAXPAYERS\" is about to start in 30 minutes. Please click on JOIN WEBINAR at the scheduled time."
/// timestamp : 1612965617
/// is_read : 0
/// webinar_flag : 2
/// webinar_id : 6122
/// webinar_type : "LIVE"
/// notification_title : "STRUCTURING UNITED STATES INVESTMENTS BY FOREIGN TAXPAYERS"
/// notification_type : "webinar"

class Notification_list {
  String _image;
  String _notificationMessage;
  String _timestamp;
  int _isRead;
  int _webinarFlag;
  int _webinarId;
  String _webinarType;
  String _notificationTitle;
  String _notificationType;

  String get image => _image;
  String get notificationMessage => _notificationMessage;
  String get timestamp => _timestamp;
  int get isRead => _isRead;
  int get webinarFlag => _webinarFlag;
  int get webinarId => _webinarId;
  String get webinarType => _webinarType;
  String get notificationTitle => _notificationTitle;
  String get notificationType => _notificationType;

  Notification_list(
      {String image,
      String notificationMessage,
      String timestamp,
      int isRead,
      int webinarFlag,
      int webinarId,
      String webinarType,
      String notificationTitle,
      String notificationType}) {
    _image = image;
    _notificationMessage = notificationMessage;
    _timestamp = timestamp;
    _isRead = isRead;
    _webinarFlag = webinarFlag;
    _webinarId = webinarId;
    _webinarType = webinarType;
    _notificationTitle = notificationTitle;
    _notificationType = notificationType;
  }

  Notification_list.fromJson(dynamic json) {
    _image = json["image"];
    _notificationMessage = json["notification_message"];
    _timestamp = json["timestamp"];
    _isRead = json["is_read"];
    _webinarFlag = json["webinar_flag"];
    _webinarId = json["webinar_id"];
    _webinarType = json["webinar_type"];
    _notificationTitle = json["notification_title"];
    _notificationType = json["notification_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    map["notification_message"] = _notificationMessage;
    map["timestamp"] = _timestamp;
    map["is_read"] = _isRead;
    map["webinar_flag"] = _webinarFlag;
    map["webinar_id"] = _webinarId;
    map["webinar_type"] = _webinarType;
    map["notification_title"] = _notificationTitle;
    map["notification_type"] = _notificationType;
    return map;
  }
}
