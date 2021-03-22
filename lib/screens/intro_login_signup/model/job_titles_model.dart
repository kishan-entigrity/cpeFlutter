/// job_title : [{"id":81,"name":"Accounting Manager"},{"id":46,"name":"Advisor"},{"id":12,"name":"Auditor"},{"id":41,"name":"Bookkeeper"},{"id":47,"name":"Business Consultant"},{"id":79,"name":"Business Development Director"},{"id":84,"name":"Certified Public Accountant (CPA)"},{"id":8,"name":"CFO/Controller"},{"id":22,"name":"Chairman"},{"id":126,"name":"Chief Communications Officer (CCO)"},{"id":6,"name":"Chief Executive Officer (CEO)"},{"id":33,"name":"Chief Financial Officer"},{"id":113,"name":"Chief Growth Officer"},{"id":34,"name":"Chief Information Officer"},{"id":35,"name":"Chief Operating Officer"},{"id":94,"name":"Chief Research Officer"},{"id":95,"name":"Chief Research Officer"},{"id":125,"name":"Chief Revenue Officer"},{"id":36,"name":"Chief Technology Officer"},{"id":119,"name":"Client Account Manager"},{"id":124,"name":"Client Success Analyst"},{"id":72,"name":"Cloud Solutions Engineer"},{"id":76,"name":"CMO"},{"id":32,"name":"Co-Founder"},{"id":131,"name":"Co-Host"},{"id":23,"name":"Co-owner"},{"id":24,"name":"Co-President"},{"id":38,"name":"Consultant"},{"id":73,"name":"Countess of Communication"},{"id":93,"name":"CPE Director"},{"id":88,"name":"Cybersecurity SME and Attorney"},{"id":127,"name":"Demand Generation"},{"id":96,"name":"Demand Generation Specialist"},{"id":117,"name":"Digital Content Manager"},{"id":37,"name":"Director"},{"id":9,"name":"Director (Finance)"},{"id":10,"name":"Director (Tax)"},{"id":128,"name":"Director of Acquisitions"},{"id":98,"name":"Director of Client Relations"},{"id":114,"name":"Director of Customer Success"},{"id":105,"name":"Director of FP&A"},{"id":132,"name":"Director of Growth"},{"id":120,"name":"Director of Information Security and Risk Management"},{"id":111,"name":"Director of Marketing"},{"id":53,"name":"Director of Marketing & Growth"},{"id":108,"name":"Director of Sales"},{"id":99,"name":"Director Product"},{"id":85,"name":"Executive Vice President"},{"id":40,"name":"Finance Controller"},{"id":11,"name":"Finance Manager"},{"id":130,"name":"Finance Transformation Specialist"},{"id":39,"name":"Financial Controller"},{"id":31,"name":"Founder"},{"id":58,"name":"Founder & CEO"},{"id":109,"name":"General Manager"},{"id":70,"name":"Government Contracts & Accounting Expert"},{"id":83,"name":"Head of Communications"},{"id":16,"name":"Human Resources"},{"id":49,"name":"Management Consultant"},{"id":14,"name":"Manager"},{"id":115,"name":"Manager - Sales & Business Development"},{"id":26,"name":"Managing Director"},{"id":27,"name":"Managing Partner"},{"id":30,"name":"Managing Principal"},{"id":29,"name":"Managing Shareholder"},{"id":82,"name":"Marketing"},{"id":103,"name":"Member"},{"id":89,"name":"Operations Manager"},{"id":19,"name":"Others"},{"id":68,"name":"Outsourced CIO"},{"id":2,"name":"Owner"},{"id":43,"name":"Paraprofessional"},{"id":3,"name":"Partner"},{"id":110,"name":"Partner Development"},{"id":106,"name":"Partner Development Team Lead"},{"id":112,"name":"Partner Manager"},{"id":100,"name":"Partner Marketing"},{"id":97,"name":"Practice Development Coach/International Expert"},{"id":7,"name":"President"},{"id":4,"name":"Principal"},{"id":48,"name":"Product Specialist"},{"id":101,"name":"Productivity Performance Coach"},{"id":66,"name":"Professor"},{"id":62,"name":"Regional Manager Mid Atlantic"},{"id":64,"name":"Registered Preparer"},{"id":77,"name":"Senior Account Executive"},{"id":104,"name":"Senior Advisor"},{"id":129,"name":"Senior Director of Finance and Corporate Controller"},{"id":123,"name":"Senior Solutions Architect"},{"id":92,"name":"Senior Vice President"},{"id":5,"name":"Shareholder"},{"id":116,"name":"Solutions Specialist"},{"id":91,"name":"Speaker"},{"id":45,"name":"Specialist"},{"id":65,"name":"Specialist Professor"},{"id":69,"name":"Sr. Associate Attorney"},{"id":71,"name":"Sr. Director"},{"id":67,"name":"Sr. Director of Partner Development and Strategy"},{"id":80,"name":"Sr. Marketing Manager"},{"id":28,"name":"Sr. Partner"},{"id":121,"name":"Sr. Sales Consultant"},{"id":102,"name":"Sr.Consultant"},{"id":42,"name":"Staff Accountant"},{"id":15,"name":"Staff or Senior"},{"id":86,"name":"Tax & Bankruptcy Attorney"},{"id":122,"name":"Tax and Client Services Director"},{"id":13,"name":"Tax Manager"},{"id":63,"name":"Tech. Expert"},{"id":74,"name":"Technical Accounting Manager"},{"id":51,"name":"Technical Solutions Consultant"},{"id":25,"name":"Vice President"},{"id":107,"name":"Vice President Of Business Development"},{"id":44,"name":"Vice President, Finance"},{"id":118,"name":"Virtual CFO"},{"id":87,"name":"VP Of Marketing"}]

class Job_titles_model {
  List<Job_title> _jobTitle;

  List<Job_title> get jobTitle => _jobTitle;

  Job_titles_model({
      List<Job_title> jobTitle}){
    _jobTitle = jobTitle;
}

  Job_titles_model.fromJson(dynamic json) {
    if (json["job_title"] != null) {
      _jobTitle = [];
      json["job_title"].forEach((v) {
        _jobTitle.add(Job_title.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_jobTitle != null) {
      map["job_title"] = _jobTitle.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 81
/// name : "Accounting Manager"

class Job_title {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Job_title({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Job_title.fromJson(dynamic json) {
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