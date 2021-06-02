/// webinar : [{"id":570,"webinar_title":"Is Credit Card Surcharging Legal - Yes and No","vimeo_url":"https://vimeo.com/366190677","webinar_type":"ON-DEMAND","speaker_name":"Jeremy Layton, BA (Business Finance)","cpa_credit":"1 CPE","fee":"","tier_name":"","product_id":"","payment_link":"","schedule_id":0,"start_date":"","start_time":"","time_zone":"","status":"Resume Watching","join_url":"","image":"","is_card_save":false},{"id":682,"webinar_title":"Build a Growth Engine for Your Practice - 5 Steps Process For Tax & CPA Firms","vimeo_url":"https://vimeo.com/370938812","webinar_type":"ON-DEMAND","speaker_name":"Matt Solomon","cpa_credit":"1 CPE","fee":"","tier_name":"","product_id":"","payment_link":"","schedule_id":0,"start_date":"","start_time":"","time_zone":"","status":"Resume Watching","join_url":"","image":"","is_card_save":false}]

class List_mywebinar {
  List<Webinar> _webinar;

  List<Webinar> get webinar => _webinar;

  List_mywebinar({List<Webinar> webinar}) {
    _webinar = webinar;
  }

  List_mywebinar.fromJson(dynamic json) {
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

/// id : 570
/// webinar_title : "Is Credit Card Surcharging Legal - Yes and No"
/// vimeo_url : "https://vimeo.com/366190677"
/// webinar_type : "ON-DEMAND"
/// speaker_name : "Jeremy Layton, BA (Business Finance)"
/// cpa_credit : "1 CPE"
/// fee : ""
/// tier_name : ""
/// product_id : ""
/// payment_link : ""
/// schedule_id : 0
/// start_date : ""
/// start_time : ""
/// time_zone : ""
/// status : "Resume Watching"
/// join_url : ""
/// image : ""
/// is_card_save : false

class Webinar {
  int _id;
  String _webinarTitle;
  String _vimeoUrl;
  String _webinarType;
  String _speakerName;
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
  String _image;
  bool _isCardSave;

  int get id => _id;
  String get webinarTitle => _webinarTitle;
  String get vimeoUrl => _vimeoUrl;
  String get webinarType => _webinarType;
  String get speakerName => _speakerName;
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
  String get image => _image;
  bool get isCardSave => _isCardSave;

  Webinar(
      {int id,
      String webinarTitle,
      String vimeoUrl,
      String webinarType,
      String speakerName,
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
      String image,
      bool isCardSave}) {
    _id = id;
    _webinarTitle = webinarTitle;
    _vimeoUrl = vimeoUrl;
    _webinarType = webinarType;
    _speakerName = speakerName;
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
    _image = image;
    _isCardSave = isCardSave;
  }

  Webinar.fromJson(dynamic json) {
    _id = json["id"];
    _webinarTitle = json["webinar_title"];
    _vimeoUrl = json["vimeo_url"];
    _webinarType = json["webinar_type"];
    _speakerName = json["speaker_name"];
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
    _image = json["image"];
    _isCardSave = json["is_card_save"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["webinar_title"] = _webinarTitle;
    map["vimeo_url"] = _vimeoUrl;
    map["webinar_type"] = _webinarType;
    map["speaker_name"] = _speakerName;
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
    map["image"] = _image;
    map["is_card_save"] = _isCardSave;
    return map;
  }
}

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
