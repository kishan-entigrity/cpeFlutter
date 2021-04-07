/// hot_topics : [{"id":60,"name":"1031"},{"id":74,"name":"1040"},{"id":91,"name":"1099"},{"id":72,"name":"199A"},{"id":29,"name":"A & A"},{"id":52,"name":"A & A Update"},{"id":30,"name":"A & A(Govt)"},{"id":100,"name":"Accounting Certifications"},{"id":63,"name":"Accounting Software"},{"id":94,"name":"American Rescue Plan 2021"},{"id":83,"name":"Artificial Intelligence"},{"id":102,"name":"Auditing"},{"id":53,"name":"Automation"},{"id":46,"name":"Business Development"},{"id":80,"name":"Business Growth"},{"id":66,"name":"Business Law"},{"id":103,"name":"Business Management"},{"id":33,"name":"Business Tax"},{"id":59,"name":"Business valuation"},{"id":70,"name":"C Corp"},{"id":40,"name":"Cannabis"},{"id":95,"name":"CARES Act"},{"id":23,"name":"CFO Topics"},{"id":101,"name":"CFP Ethics"},{"id":44,"name":"Cloud"},{"id":90,"name":"Communication"},{"id":99,"name":"Continuing Education"},{"id":71,"name":"COVID"},{"id":39,"name":"Cryptocurrency"},{"id":27,"name":"CyberSecurity"},{"id":82,"name":"Data Analytics"},{"id":98,"name":"ERC"},{"id":17,"name":"Estate Planning"},{"id":37,"name":"Ethics"},{"id":12,"name":"Excel"},{"id":36,"name":"Finance"},{"id":35,"name":"Financial & Retirement Planning"},{"id":92,"name":"Financial Planning"},{"id":84,"name":"Financial Reporting"},{"id":25,"name":"Fraud & Forensics"},{"id":5,"name":"Free Ethics"},{"id":96,"name":"Home Office Deduction"},{"id":77,"name":"Human Resources"},{"id":81,"name":"IFRS"},{"id":32,"name":"Individual Tax"},{"id":87,"name":"Insurance"},{"id":58,"name":"Internal Control"},{"id":28,"name":"International Taxes"},{"id":73,"name":"IRA"},{"id":79,"name":"IRS Representation"},{"id":78,"name":"Leadership"},{"id":38,"name":"Lease"},{"id":47,"name":"Management"},{"id":65,"name":"Management Accounting"},{"id":49,"name":"Marketing"},{"id":88,"name":"Mergers & Acquisitions"},{"id":97,"name":"New 941"},{"id":34,"name":"Non-Profit"},{"id":61,"name":"Opportunity Zones"},{"id":41,"name":"Partnerships"},{"id":26,"name":"Payroll"},{"id":104,"name":"Personal Development"},{"id":75,"name":"PPP"},{"id":56,"name":"Practice Management"},{"id":55,"name":"Presentation"},{"id":15,"name":"Quickbooks"},{"id":64,"name":"Real Estate"},{"id":57,"name":"Revenue Recognition"},{"id":85,"name":"Review & Compilations"},{"id":86,"name":"Risk Management"},{"id":42,"name":"S Corp"},{"id":21,"name":"Sales Tax"},{"id":20,"name":"SALT"},{"id":76,"name":"SECURE ACT"},{"id":93,"name":"Stimulus Bill 2020"},{"id":45,"name":"Tax credits & incentives"},{"id":19,"name":"Tax Planning"},{"id":22,"name":"Tax Resolution"},{"id":43,"name":"Tax Updates"},{"id":18,"name":"Taxes"},{"id":50,"name":"TCJA"},{"id":31,"name":"Technology"},{"id":54,"name":"Time Management"},{"id":89,"name":"Yellow Book"}]

class List_hot_topics {
  List<Hot_topics> _hotTopics;

  List<Hot_topics> get hotTopics => _hotTopics;

  List_hot_topics({List<Hot_topics> hotTopics}) {
    _hotTopics = hotTopics;
  }

  List_hot_topics.fromJson(dynamic json) {
    if (json["hot_topics"] != null) {
      _hotTopics = [];
      json["hot_topics"].forEach((v) {
        _hotTopics.add(Hot_topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_hotTopics != null) {
      map["hot_topics"] = _hotTopics.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 60
/// name : "1031"

class Hot_topics {
  int _id;
  String _name;
  String _hot_topics;
  bool _isSelected = false;

  int get id => _id;
  String get name => _name;
  String get hot_topic => _hot_topics;
  bool get isSelected => _isSelected;

  set isSelected(bool isSelected) {
    this._isSelected = isSelected;
  }

  Hot_topics({int id, String name, String hot_topics}) {
    _id = id;
    _name = name;
    _hot_topics = hot_topic;
  }

  Hot_topics.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _hot_topics = json["hot_topic"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["hot_topic"] = _hot_topics;
    return map;
  }
}
