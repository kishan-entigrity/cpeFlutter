/// RecentWebinars : [{"id":604,"webinar_title":"FUNDAMENTALS OF INCOME TAXATION OF TRUSTS & FORM 1041 PLANNING: WHAT EVERY ADVISORS NEEDS TO KNOW","webinar_type":"self-study","webinar_image":"https://my-cpe.com/uploads/webinar_image/image_1593427855.png"},{"id":605,"webinar_title":"UNDERSTANDING & ADOPTING THE NEW REVENUE RECOGNITION STANDARD","webinar_type":"self-study","webinar_image":"https://my-cpe.com/uploads/webinar_image/image_1593681824.png"},{"id":606,"webinar_title":"TAX CONSEQUENCES ON THE CARES ACT – OVERVIEW OF MAJOR TAX ISSUES FROM THE CARES ACT AND RELATED NOTICE INCLUDING PLANNING TECHNIQUES","webinar_type":"self-study","webinar_image":"https://my-cpe.com/uploads/webinar_image/image_1593427855.png"},{"id":607,"webinar_title":"CPA & ACCOUNTANTS: WHAT YOU SHOULD KNOW ABOUT CREDIT CARD SURCHARGING & IT'S LEGALITY","webinar_type":"self-study","webinar_image":"https://my-cpe.com/uploads/webinar_image/image_1593681824.png"}]

class Recent_webinar_data {
  List<RecentWebinars> _recentWebinars;

  List<RecentWebinars> get recentWebinars => _recentWebinars;

  Recent_webinar_data({List<RecentWebinars> recentWebinars}) {
    _recentWebinars = recentWebinars;
  }

  Recent_webinar_data.fromJson(dynamic json) {
    if (json["RecentWebinars"] != null) {
      _recentWebinars = [];
      json["RecentWebinars"].forEach((v) {
        _recentWebinars.add(RecentWebinars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_recentWebinars != null) {
      map["RecentWebinars"] = _recentWebinars.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 604
/// webinar_title : "FUNDAMENTALS OF INCOME TAXATION OF TRUSTS & FORM 1041 PLANNING: WHAT EVERY ADVISORS NEEDS TO KNOW"
/// webinar_type : "self-study"
/// webinar_image : "https://my-cpe.com/uploads/webinar_image/image_1593427855.png"

class RecentWebinars {
  int _id;
  String _webinarTitle;
  String _webinarType;
  String _webinarImage;

  int get id => _id;
  String get webinarTitle => _webinarTitle;
  String get webinarType => _webinarType;
  String get webinarImage => _webinarImage;

  RecentWebinars({int id, String webinarTitle, String webinarType, String webinarImage}) {
    _id = id;
    _webinarTitle = webinarTitle;
    _webinarType = webinarType;
    _webinarImage = webinarImage;
  }

  RecentWebinars.fromJson(dynamic json) {
    _id = json["id"];
    _webinarTitle = json["webinar_title"];
    _webinarType = json["webinar_type"];
    _webinarImage = json["webinar_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["webinar_title"] = _webinarTitle;
    map["webinar_type"] = _webinarType;
    map["webinar_image"] = _webinarImage;
    return map;
  }
}
