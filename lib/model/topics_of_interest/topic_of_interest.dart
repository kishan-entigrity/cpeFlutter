/// success : true
/// message : "success"
/// payload : {"topic_of_interests":[{"id":266,"name":" Tax cuts and job act"},{"id":286,"name":"230"},{"id":291,"name":"230 ethics"},{"id":234,"name":"Accounting Software"},{"id":290,"name":"AICPA ethics"},{"id":279,"name":"Banking"},{"id":263,"name":"Cannabis"},{"id":287,"name":"circular"},{"id":285,"name":"circular 230"},{"id":237,"name":"Cloud"},{"id":254,"name":"Coaching & mentoring"},{"id":255,"name":"Communication skills"},{"id":233,"name":"Compilation & Review"},{"id":242,"name":"Corporate tax"},{"id":236,"name":"Cyber Security"},{"id":245,"name":"Estate Tax"},{"id":240,"name":"Ethics Behavioral"},{"id":292,"name":"ethics for tax professionals"},{"id":239,"name":"Ethics Regulatory"},{"id":278,"name":"Expatriates Tax"},{"id":247,"name":"Federal tax"},{"id":289,"name":"federal tax ethics"},{"id":231,"name":"Financial Reporting"},{"id":238,"name":"Financial Software"},{"id":277,"name":"Foriegners Tax"},{"id":271,"name":"Grammer"},{"id":274,"name":"impactful writing"},{"id":272,"name":"Important email"},{"id":248,"name":"Individual income tax"},{"id":275,"name":"influential writing"},{"id":232,"name":"Internal Control"},{"id":276,"name":"International Tax"},{"id":250,"name":"International tax"},{"id":280,"name":"Investment Banking"},{"id":262,"name":"Lead Generation"},{"id":259,"name":"Linkedin"},{"id":252,"name":"LLC & partnership tax"},{"id":264,"name":"Marijuana"},{"id":282,"name":"non profit"},{"id":283,"name":"non-profit"},{"id":281,"name":"nonprofit"},{"id":258,"name":"Nonprofit accounting"},{"id":257,"name":"Nonprofit audit"},{"id":284,"name":"nonprofit cpe"},{"id":260,"name":"Online Marekting"},{"id":241,"name":"Professional"},{"id":253,"name":"Property tax"},{"id":244,"name":"Sales, use & excise tax"},{"id":243,"name":"SALT"},{"id":261,"name":"Social Media"},{"id":246,"name":"State & local taxation"},{"id":249,"name":"Tax credits & incentives"},{"id":288,"name":"tax ethics"},{"id":251,"name":"Tax law"},{"id":256,"name":"Tax Planning"},{"id":235,"name":"Tax Preparation Software"},{"id":267,"name":"Tax Updates 2019"},{"id":265,"name":"TJCA"},{"id":273,"name":"writing"}],"subject_area":[{"id":27,"name":"Accounting"},{"id":34,"name":"Accounting (Govt.)"},{"id":4,"name":"Accounting & Auditing"},{"id":38,"name":"Accounting & Auditing (Govt.)"},{"id":5,"name":"Auditing"},{"id":33,"name":"Auditing (Govt.)"},{"id":6,"name":"Business Law"},{"id":7,"name":"Business Management and Organization"},{"id":8,"name":"Communications & Marketing"},{"id":9,"name":"Computer Software and Applications"},{"id":35,"name":"Economics"},{"id":10,"name":"Ethics (Behavioral)"},{"id":11,"name":"Ethics (Regulatory)"},{"id":30,"name":"Federal Tax Related Matters"},{"id":12,"name":"Finance"},{"id":18,"name":"Human Resources"},{"id":13,"name":"Information Technology"},{"id":14,"name":"Management Services"},{"id":17,"name":"Personal Development"},{"id":37,"name":"Production"},{"id":20,"name":"Specialized Knowledge"},{"id":22,"name":"Taxes"}]}

class Topic_of_interest {
  bool _success;
  String _message;
  Payload _payload;

  bool get success => _success;
  String get message => _message;
  Payload get payload => _payload;

  Topic_of_interest({bool success, String message, Payload payload}) {
    _success = success;
    _message = message;
    _payload = payload;
  }

  Topic_of_interest.fromJson(dynamic json) {
    _success = json["success"];
    _message = json["message"];
    _payload =
        json["payload"] != null ? Payload.fromJson(json["payload"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;
    if (_payload != null) {
      map["payload"] = _payload.toJson();
    }
    return map;
  }
}

/// topic_of_interests : [{"id":266,"name":" Tax cuts and job act"},{"id":286,"name":"230"},{"id":291,"name":"230 ethics"},{"id":234,"name":"Accounting Software"},{"id":290,"name":"AICPA ethics"},{"id":279,"name":"Banking"},{"id":263,"name":"Cannabis"},{"id":287,"name":"circular"},{"id":285,"name":"circular 230"},{"id":237,"name":"Cloud"},{"id":254,"name":"Coaching & mentoring"},{"id":255,"name":"Communication skills"},{"id":233,"name":"Compilation & Review"},{"id":242,"name":"Corporate tax"},{"id":236,"name":"Cyber Security"},{"id":245,"name":"Estate Tax"},{"id":240,"name":"Ethics Behavioral"},{"id":292,"name":"ethics for tax professionals"},{"id":239,"name":"Ethics Regulatory"},{"id":278,"name":"Expatriates Tax"},{"id":247,"name":"Federal tax"},{"id":289,"name":"federal tax ethics"},{"id":231,"name":"Financial Reporting"},{"id":238,"name":"Financial Software"},{"id":277,"name":"Foriegners Tax"},{"id":271,"name":"Grammer"},{"id":274,"name":"impactful writing"},{"id":272,"name":"Important email"},{"id":248,"name":"Individual income tax"},{"id":275,"name":"influential writing"},{"id":232,"name":"Internal Control"},{"id":276,"name":"International Tax"},{"id":250,"name":"International tax"},{"id":280,"name":"Investment Banking"},{"id":262,"name":"Lead Generation"},{"id":259,"name":"Linkedin"},{"id":252,"name":"LLC & partnership tax"},{"id":264,"name":"Marijuana"},{"id":282,"name":"non profit"},{"id":283,"name":"non-profit"},{"id":281,"name":"nonprofit"},{"id":258,"name":"Nonprofit accounting"},{"id":257,"name":"Nonprofit audit"},{"id":284,"name":"nonprofit cpe"},{"id":260,"name":"Online Marekting"},{"id":241,"name":"Professional"},{"id":253,"name":"Property tax"},{"id":244,"name":"Sales, use & excise tax"},{"id":243,"name":"SALT"},{"id":261,"name":"Social Media"},{"id":246,"name":"State & local taxation"},{"id":249,"name":"Tax credits & incentives"},{"id":288,"name":"tax ethics"},{"id":251,"name":"Tax law"},{"id":256,"name":"Tax Planning"},{"id":235,"name":"Tax Preparation Software"},{"id":267,"name":"Tax Updates 2019"},{"id":265,"name":"TJCA"},{"id":273,"name":"writing"}]
/// subject_area : [{"id":27,"name":"Accounting"},{"id":34,"name":"Accounting (Govt.)"},{"id":4,"name":"Accounting & Auditing"},{"id":38,"name":"Accounting & Auditing (Govt.)"},{"id":5,"name":"Auditing"},{"id":33,"name":"Auditing (Govt.)"},{"id":6,"name":"Business Law"},{"id":7,"name":"Business Management and Organization"},{"id":8,"name":"Communications & Marketing"},{"id":9,"name":"Computer Software and Applications"},{"id":35,"name":"Economics"},{"id":10,"name":"Ethics (Behavioral)"},{"id":11,"name":"Ethics (Regulatory)"},{"id":30,"name":"Federal Tax Related Matters"},{"id":12,"name":"Finance"},{"id":18,"name":"Human Resources"},{"id":13,"name":"Information Technology"},{"id":14,"name":"Management Services"},{"id":17,"name":"Personal Development"},{"id":37,"name":"Production"},{"id":20,"name":"Specialized Knowledge"},{"id":22,"name":"Taxes"}]

class Payload {
  List<Topic_of_interests> _topicOfInterests;
  List<Subject_area> _subjectArea;

  List<Topic_of_interests> get topicOfInterests => _topicOfInterests;
  List<Subject_area> get subjectArea => _subjectArea;

  Payload(
      {List<Topic_of_interests> topicOfInterests,
      List<Subject_area> subjectArea}) {
    _topicOfInterests = topicOfInterests;
    _subjectArea = subjectArea;
  }

  Payload.fromJson(dynamic json) {
    if (json["topic_of_interests"] != null) {
      _topicOfInterests = [];
      json["topic_of_interests"].forEach((v) {
        _topicOfInterests.add(Topic_of_interests.fromJson(v));
      });
    }
    if (json["subject_area"] != null) {
      _subjectArea = [];
      json["subject_area"].forEach((v) {
        _subjectArea.add(Subject_area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_topicOfInterests != null) {
      map["topic_of_interests"] =
          _topicOfInterests.map((v) => v.toJson()).toList();
    }
    if (_subjectArea != null) {
      map["subject_area"] = _subjectArea.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 27
/// name : "Accounting"

class Subject_area {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Subject_area({int id, String name}) {
    _id = id;
    _name = name;
  }

  Subject_area.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}

/// id : 266
/// name : " Tax cuts and job act"

class Topic_of_interests {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Topic_of_interests({int id, String name}) {
    _id = id;
    _name = name;
  }

  Topic_of_interests.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}
