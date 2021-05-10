/// webinar : [{"id":373,"webinar_title":"EMAIL EXTINGUISHER - SIMPLE STEPS TO SHRINK THE INBOX","webinar_type":"ON-DEMAND","speaker_name":"Marcey Rader","audiance_id":"1,47","audiance_titles":["ACCT_BK","PFS"],"cpa_credit":"1 Credit","fee":"10","tier_name":"Basic","product_id":"Entigrity.inc.MyNewCPE.BasicPackSgten","payment_link":"https://testing-website.in/api/webinar/webinar-payment-form/eyJpdiI6InNwVlJLWXU4Z0VabjJBa1pDWFdmQmc9PSIsInZhbHVlIjoiRGZoOWpcL3BpWVNEZ1lRMzU1V0s1d1E9PSIsIm1hYyI6ImFlY2I0MTVmZTk3NjA2YzgwODRhNjEwN2QyYTczM2YzZjdkNDlhNjY3NDlmOWNkMTMzMDRiMzY4MmMyMmMwMDEifQ==/eyJpdiI6IlJvSUZ3dEFlVjNkK2xsVFdjSG04K3c9PSIsInZhbHVlIjoiRXVwd1RJU1lkZTh5ZXVQR3pcL2Q2a0E9PSIsIm1hYyI6ImQwNzMyMGI4N2Y5MDhlMjEyOGRjYmE3ZTI2NDk1ZjhlZDEyYmYwOTNlYzQzNWI0ZmEwOTQ0NWNjNTRjMjhjYTMifQ==","schedule_id":0,"start_date":"","start_time":"","time_zone":"","my_certificate_links":[{"certificate_type":"","certificate_link":""},null],"status":"Register","join_url":"email-extinguisher---simple-steps-to-shrink-the-inbox6","encrypted_zoom_link":"","zoom_link_status":false,"zoom_link_verification_message":"","is_card_save":false},{"id":374,"webinar_title":"DOES YOUR CLIENT OWN SHARES IN FOREIGN CORPORATION? IMPACT OF TJCA","webinar_type":"ON-DEMAND","speaker_name":"Imtiaz Munshi, CGA","audiance_id":"20,4,1,3,5,9","audiance_titles":["ACCT_BK","ABV","AIF","AFSP","CCSA","CGFM"],"cpa_credit":"1 Credit","fee":"9","tier_name":"Basic","product_id":"Entigrity.inc.MyNewCPE.BasicPackSgnine","payment_link":"https://testing-website.in/api/webinar/webinar-payment-form/eyJpdiI6ImVkMGlWeXltdFZpTUR1QzErZUF0Q2c9PSIsInZhbHVlIjoiM1dEajc5eVZ2YVNGZHFHeWJXSG1iUT09IiwibWFjIjoiMjlkYzZlNTMwZThjZDliOTY2ZTE5MjUzNmM0MjhlMGE1MmU2MTdlMDU3NDU5MDRlMmU1MGJmOTFlMzBjZjliZCJ9/eyJpdiI6InpiTDdaKzRlNDJUb3JIMEVSdXp6Y2c9PSIsInZhbHVlIjoiMllVbXZZZE9NQkxMZ1hseXdsT2hwdz09IiwibWFjIjoiZTZkNTI3MjdmYTFmNzhkN2ZjOTBiZTc0YWY5NzRlOTBmZTMwMzJkMTEwYzY3NDM4Y2UzNjQ4NGYxYjU1YzVmNCJ9","schedule_id":0,"start_date":"","start_time":"","time_zone":"","my_certificate_links":[],"status":"Resume Watching","join_url":"does-your-client-own-shares-in-foreign-corporation-impact-of-tjca8","encrypted_zoom_link":"","zoom_link_status":false,"zoom_link_verification_message":"","is_card_save":false}]

class Webinar_list_new {
  List<Webinar> _webinar;

  List<Webinar> get webinar => _webinar;

  Webinar_list_new({List<Webinar> webinar}) {
    _webinar = webinar;
  }

  Webinar_list_new.fromJson(dynamic json) {
    if (json["webinar"] != null) {
      _webinar = [];
      json["webinar"].forEach((v) {
        _webinar.add(Webinar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_webinar != null) {
      map["webinar"] = _webinar.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 373
/// webinar_title : "EMAIL EXTINGUISHER - SIMPLE STEPS TO SHRINK THE INBOX"
/// webinar_type : "ON-DEMAND"
/// speaker_name : "Marcey Rader"
/// audiance_id : "1,47"
/// audiance_titles : ["ACCT_BK","PFS"]
/// cpa_credit : "1 Credit"
/// fee : "10"
/// tier_name : "Basic"
/// product_id : "Entigrity.inc.MyNewCPE.BasicPackSgten"
/// payment_link : "https://testing-website.in/api/webinar/webinar-payment-form/eyJpdiI6InNwVlJLWXU4Z0VabjJBa1pDWFdmQmc9PSIsInZhbHVlIjoiRGZoOWpcL3BpWVNEZ1lRMzU1V0s1d1E9PSIsIm1hYyI6ImFlY2I0MTVmZTk3NjA2YzgwODRhNjEwN2QyYTczM2YzZjdkNDlhNjY3NDlmOWNkMTMzMDRiMzY4MmMyMmMwMDEifQ==/eyJpdiI6IlJvSUZ3dEFlVjNkK2xsVFdjSG04K3c9PSIsInZhbHVlIjoiRXVwd1RJU1lkZTh5ZXVQR3pcL2Q2a0E9PSIsIm1hYyI6ImQwNzMyMGI4N2Y5MDhlMjEyOGRjYmE3ZTI2NDk1ZjhlZDEyYmYwOTNlYzQzNWI0ZmEwOTQ0NWNjNTRjMjhjYTMifQ=="
/// schedule_id : 0
/// start_date : ""
/// start_time : ""
/// time_zone : ""
/// my_certificate_links : [{"certificate_type":"","certificate_link":""},null]
/// status : "Register"
/// join_url : "email-extinguisher---simple-steps-to-shrink-the-inbox6"
/// encrypted_zoom_link : ""
/// zoom_link_status : false
/// zoom_link_verification_message : ""
/// is_card_save : false

class Webinar {
  int _id;
  String _webinarTitle;
  String _webinarType;
  String _speakerName;
  String _audianceId;
  List<String> _audianceTitles;
  String _cpaCredit;
  String _fee;
  String _tierName;
  String _productId;
  String _paymentLink;
  int _scheduleId;
  String _startDate;
  String _startTime;
  String _timeZone;
  List<My_certificate_links> _myCertificateLinks;
  String _status;
  String _joinUrl;
  String _encryptedZoomLink;
  bool _zoomLinkStatus;
  String _zoomLinkVerificationMessage;
  bool _isCardSave;

  int get id => _id;
  String get webinarTitle => _webinarTitle;
  String get webinarType => _webinarType;
  String get speakerName => _speakerName;
  String get audianceId => _audianceId;
  List<String> get audianceTitles => _audianceTitles;
  String get cpaCredit => _cpaCredit;
  String get fee => _fee;
  String get tierName => _tierName;
  String get productId => _productId;
  String get paymentLink => _paymentLink;
  int get scheduleId => _scheduleId;
  String get startDate => _startDate;
  String get startTime => _startTime;
  String get timeZone => _timeZone;
  List<My_certificate_links> get myCertificateLinks => _myCertificateLinks;
  String get status => _status;
  String get joinUrl => _joinUrl;
  String get encryptedZoomLink => _encryptedZoomLink;
  bool get zoomLinkStatus => _zoomLinkStatus;
  String get zoomLinkVerificationMessage => _zoomLinkVerificationMessage;
  bool get isCardSave => _isCardSave;

  set status(String status) {
    this._status = status;
  }

  Webinar(
      {int id,
      String webinarTitle,
      String webinarType,
      String speakerName,
      String audianceId,
      List<String> audianceTitles,
      String cpaCredit,
      String fee,
      String tierName,
      String productId,
      String paymentLink,
      int scheduleId,
      String startDate,
      String startTime,
      String timeZone,
      List<My_certificate_links> myCertificateLinks,
      String status,
      String joinUrl,
      String encryptedZoomLink,
      bool zoomLinkStatus,
      String zoomLinkVerificationMessage,
      bool isCardSave}) {
    _id = id;
    _webinarTitle = webinarTitle;
    _webinarType = webinarType;
    _speakerName = speakerName;
    _audianceId = audianceId;
    _audianceTitles = audianceTitles;
    _cpaCredit = cpaCredit;
    _fee = fee;
    _tierName = tierName;
    _productId = productId;
    _paymentLink = paymentLink;
    _scheduleId = scheduleId;
    _startDate = startDate;
    _startTime = startTime;
    _timeZone = timeZone;
    _myCertificateLinks = myCertificateLinks;
    _status = status;
    _joinUrl = joinUrl;
    _encryptedZoomLink = encryptedZoomLink;
    _zoomLinkStatus = zoomLinkStatus;
    _zoomLinkVerificationMessage = zoomLinkVerificationMessage;
    _isCardSave = isCardSave;
  }

  Webinar.fromJson(dynamic json) {
    _id = json["id"];
    _webinarTitle = json["webinar_title"];
    _webinarType = json["webinar_type"];
    _speakerName = json["speaker_name"];
    _audianceId = json["audiance_id"];
    _audianceTitles = json["audiance_titles"] != null ? json["audiance_titles"].cast<String>() : [];
    _cpaCredit = json["cpa_credit"];
    _fee = json["fee"];
    _tierName = json["tier_name"];
    _productId = json["product_id"];
    _paymentLink = json["payment_link"];
    _scheduleId = json["schedule_id"];
    _startDate = json["start_date"];
    _startTime = json["start_time"];
    _timeZone = json["time_zone"];
    if (json["my_certificate_links"] != null) {
      _myCertificateLinks = [];
      json["my_certificate_links"].forEach((v) {
        _myCertificateLinks.add(My_certificate_links.fromJson(v));
      });
    }
    _status = json["status"];
    _joinUrl = json["join_url"];
    _encryptedZoomLink = json["encrypted_zoom_link"];
    _zoomLinkStatus = json["zoom_link_status"];
    _zoomLinkVerificationMessage = json["zoom_link_verification_message"];
    _isCardSave = json["is_card_save"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["webinar_title"] = _webinarTitle;
    map["webinar_type"] = _webinarType;
    map["speaker_name"] = _speakerName;
    map["audiance_id"] = _audianceId;
    map["audiance_titles"] = _audianceTitles;
    map["cpa_credit"] = _cpaCredit;
    map["fee"] = _fee;
    map["tier_name"] = _tierName;
    map["product_id"] = _productId;
    map["payment_link"] = _paymentLink;
    map["schedule_id"] = _scheduleId;
    map["start_date"] = _startDate;
    map["start_time"] = _startTime;
    map["time_zone"] = _timeZone;
    if (_myCertificateLinks != null) {
      map["my_certificate_links"] = _myCertificateLinks.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["join_url"] = _joinUrl;
    map["encrypted_zoom_link"] = _encryptedZoomLink;
    map["zoom_link_status"] = _zoomLinkStatus;
    map["zoom_link_verification_message"] = _zoomLinkVerificationMessage;
    map["is_card_save"] = _isCardSave;
    return map;
  }
}

/// certificate_type : ""
/// certificate_link : ""

class My_certificate_links {
  String _certificateType;
  String _certificateLink;

  String get certificateType => _certificateType;
  String get certificateLink => _certificateLink;

  My_certificate_links({String certificateType, String certificateLink}) {
    _certificateType = certificateType;
    _certificateLink = certificateLink;
  }

  My_certificate_links.fromJson(dynamic json) {
    _certificateType = json["certificate_type"];
    _certificateLink = json["certificate_link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["certificate_type"] = _certificateType;
    map["certificate_link"] = _certificateLink;
    return map;
  }
}
