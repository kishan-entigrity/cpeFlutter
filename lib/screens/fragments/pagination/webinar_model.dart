/// webinar : [{"id":555,"webinar_title":"INTRO TO ACCOUNTINGSUITE™ & MULTI-CHANNEL INVENTORY","webinar_type":"ON-DEMAND","speaker_name":"Edward Mcrae, CPA","cpa_credit":"1 CPE","fee":"FREE","tier_name":"","product_id":"","payment_link":"","schedule_id":0,"start_date":"","start_time":"","time_zone":"","status":"Register","join_url":"intro-to-accountingsuite-and-multi-channel-inventory65","is_card_save":false},{"id":567,"webinar_title":"Transfer Pricing and Tax Reform Opportunities","webinar_type":"ON-DEMAND","speaker_name":"Alex Martin, Masters in Public Policy","cpa_credit":"1.5 CPE","fee":"FREE","tier_name":"","product_id":"","payment_link":"","schedule_id":0,"start_date":"","start_time":"","time_zone":"","status":"Register","join_url":"transfer-pricing-and-tax-reform-opportunities1","is_card_save":false},{"id":570,"webinar_title":"Is Credit Card Surcharging Legal - Yes and No","webinar_type":"ON-DEMAND","speaker_name":"Jeremy Layton, BA (Business Finance)","cpa_credit":"1 CPE","fee":"FREE","tier_name":"","product_id":"","payment_link":"","schedule_id":0,"start_date":"","start_time":"","time_zone":"","status":"Register","join_url":"is-credit-card-surcharging-legal---yes-and-no","is_card_save":false}]

class Webinar_model {
  List<Webinar> _webinar;

  List<Webinar> get webinar => _webinar;

  Webinar_model({List<Webinar> webinar}) {
    _webinar = webinar;
  }

  Webinar_model.fromJson(dynamic json) {
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

/// id : 555
/// webinar_title : "INTRO TO ACCOUNTINGSUITE™ & MULTI-CHANNEL INVENTORY"
/// webinar_type : "ON-DEMAND"
/// speaker_name : "Edward Mcrae, CPA"
/// cpa_credit : "1 CPE"
/// fee : "FREE"
/// tier_name : ""
/// product_id : ""
/// payment_link : ""
/// schedule_id : 0
/// start_date : ""
/// start_time : ""
/// time_zone : ""
/// status : "Register"
/// join_url : "intro-to-accountingsuite-and-multi-channel-inventory65"
/// is_card_save : false

class Webinar {
  int _id;
  String _webinarTitle;
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
  String _status;
  String _joinUrl;
  bool _isCardSave;

  int get id => _id;
  String get webinarTitle => _webinarTitle;
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
  String get status => _status;
  String get joinUrl => _joinUrl;
  bool get isCardSave => _isCardSave;

  Webinar(
      {int id,
      String webinarTitle,
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
      String status,
      String joinUrl,
      bool isCardSave}) {
    _id = id;
    _webinarTitle = webinarTitle;
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
    _status = status;
    _joinUrl = joinUrl;
    _isCardSave = isCardSave;
  }

  Webinar.fromJson(dynamic json) {
    _id = json["id"];
    _webinarTitle = json["webinar_title"];
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
    _status = json["status"];
    _joinUrl = json["join_url"];
    _isCardSave = json["is_card_save"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["webinar_title"] = _webinarTitle;
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
    map["status"] = _status;
    map["join_url"] = _joinUrl;
    map["is_card_save"] = _isCardSave;
    return map;
  }
}
