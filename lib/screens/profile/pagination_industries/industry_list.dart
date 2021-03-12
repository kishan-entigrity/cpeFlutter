/// industries_list : [{"id":26,"name":"Accountants or Bookkeepers"},{"id":22,"name":"Accounting Firms"},{"id":29,"name":"Banking & Financial Services"},{"id":32,"name":"Business Broking/Valuation"},{"id":27,"name":"Financial Planning/Investment/Wealth Management"},{"id":33,"name":"Fraud & Forensics"},{"id":34,"name":"Government"},{"id":30,"name":"Insurance"},{"id":24,"name":"Law Firms"},{"id":6,"name":"Others"},{"id":31,"name":"Payroll"},{"id":23,"name":"Private Industry"},{"id":25,"name":"Tax Practice"},{"id":35,"name":"Trust & Estate Planning"}]

class Industry_list {
  List<Industries_list> _industriesList;

  List<Industries_list> get industriesList => _industriesList;

  Industry_list({List<Industries_list> industriesList}) {
    _industriesList = industriesList;
  }

  Industry_list.fromJson(dynamic json) {
    if (json["industries_list"] != null) {
      _industriesList = [];
      json["industries_list"].forEach((v) {
        _industriesList.add(Industries_list.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_industriesList != null) {
      map["industries_list"] = _industriesList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 26
/// name : "Accountants or Bookkeepers"

class Industries_list {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Industries_list({int id, String name}) {
    _id = id;
    _name = name;
  }

  Industries_list.fromJson(dynamic json) {
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
