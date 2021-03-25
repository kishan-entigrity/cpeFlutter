/// my_credits : [{"webinar_id":4976,"webinar_title":"Going Concern - Implication in Accounting, Disclosure & Reporting","speaker_name":"Brad Muniz","credit":"1","ce_credit":"","webinar_credit_type":"CPE","subject":"Accounting & Auditing","webinar_type":"ON-DEMAND","host_date":"","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/self_study_webinar/cpe/going-concern---implication-in-accountingdisclosure-and-reporting-1606916622_561176889.pdf"}],"certificate_link":["https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/self_study_webinar/cpe/going-concern---implication-in-accountingdisclosure-and-reporting-1606916622_561176889.pdf"]},{"webinar_id":3297,"webinar_title":"Ethics For Oregon CPAs","speaker_name":"Allison McLeod","credit":"4","ce_credit":"","webinar_credit_type":"CPE","subject":"Ethics (Regulatory)","webinar_type":"ON-DEMAND","host_date":"","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://my-cpe.com/storage/pdf/self_study_webinar/cpe/ethics-for-oregon-cpas-1597937789_561176893.pdf"}],"certificate_link":["https://my-cpe.com/storage/pdf/self_study_webinar/cpe/ethics-for-oregon-cpas-1597937789_561176893.pdf"]},{"webinar_id":63,"webinar_title":"INTERNATIONAL TAX FOR THE GROWING BUSINESS","speaker_name":"Patrick McCormick","credit":"1.5","ce_credit":"1","webinar_credit_type":"CPE/CE","subject":"Taxes","webinar_type":"LIVE","host_date":"20 Jun 2019","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-cpe-international-tax-for-the-growing-business6_559.pdf"},{"certificate_type":"CE","certificate_link":"https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-ce-international-tax-for-the-growing-business6_559.pdf"}],"certificate_link":["https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-cpe-international-tax-for-the-growing-business6_559.pdf"]},{"webinar_id":2089,"webinar_title":"IRS COLLECTION REPRESENTATION IN THE WAKE OF COVID-19","speaker_name":"Jason Freeman","credit":"1","ce_credit":"1","webinar_credit_type":"CPE/CE","subject":"Taxes","webinar_type":"LIVE","host_date":"14 May 2020","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-cpe-updates-on-coronavirus-covid-19-tax-and-business-relief-the-latest-developments-1588864571_561010800.pdf"},{"certificate_type":"CE","certificate_link":"https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-ce-updates-on-coronavirus-covid-19-tax-and-business-relief-the-latest-developments-1588864571_561010800.pdf"}],"certificate_link":["https://my-cpe.com/storage/pdf/live_webinar/cpe_ce/mycpe-cpe-updates-on-coronavirus-covid-19-tax-and-business-relief-the-latest-developments-1588864571_561010800.pdf"]},{"webinar_id":2927,"webinar_title":"BEYOND WORKING REMOTELY – Case Studies | Benefits | Challenges for Accounting & Tax Firms.","speaker_name":"Chris Rivera","credit":"1","ce_credit":"","webinar_credit_type":"CPE","subject":"Business Management and Organization","webinar_type":"LIVE","host_date":"26 Aug 2020","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://my-cpe.com/storage/pdf/live_webinar/cpe/beyond-working-remotely-case-studies-benefits-challenges-for-accounting-and-tax-firms-1595455154-469_561075455.pdf"}],"certificate_link":["https://my-cpe.com/storage/pdf/live_webinar/cpe/beyond-working-remotely-case-studies-benefits-challenges-for-accounting-and-tax-firms-1595455154-469_561075455.pdf"]},{"webinar_id":4658,"webinar_title":"REGULATORY ETHICS GUIDEBOOK FOR CPAs: AICPA CODE OF PROFESSIONAL CONDUCT","speaker_name":"Allison McLeod","credit":"4","ce_credit":"","webinar_credit_type":"CPE","subject":"Ethics (Regulatory)","webinar_type":"LIVE","host_date":"18 Dec 2020","webinar_status":"MY CERTIFICATE","joinUrl":"","my_certificate_links":[{"certificate_type":"CPE","certificate_link":"https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/live_webinar/cpe/regulatory-ethics-guidebook-for-cpas-aicpa-code-of-professional-conduct-1605715234_561196219.pdf"}],"certificate_link":["https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/live_webinar/cpe/regulatory-ethics-guidebook-for-cpas-aicpa-code-of-professional-conduct-1605715234_561196219.pdf"]}]

class Credit_model {
  List<My_credits> _myCredits;

  List<My_credits> get myCredits => _myCredits;

  Credit_model({List<My_credits> myCredits}) {
    _myCredits = myCredits;
  }

  Credit_model.fromJson(dynamic json) {
    if (json["my_credits"] != null) {
      _myCredits = [];
      json["my_credits"].forEach((v) {
        _myCredits.add(My_credits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_myCredits != null) {
      map["my_credits"] = _myCredits.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// webinar_id : 4976
/// webinar_title : "Going Concern - Implication in Accounting, Disclosure & Reporting"
/// speaker_name : "Brad Muniz"
/// credit : "1"
/// ce_credit : ""
/// webinar_credit_type : "CPE"
/// subject : "Accounting & Auditing"
/// webinar_type : "ON-DEMAND"
/// host_date : ""
/// webinar_status : "MY CERTIFICATE"
/// joinUrl : ""
/// my_certificate_links : [{"certificate_type":"CPE","certificate_link":"https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/self_study_webinar/cpe/going-concern---implication-in-accountingdisclosure-and-reporting-1606916622_561176889.pdf"}]
/// certificate_link : ["https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/self_study_webinar/cpe/going-concern---implication-in-accountingdisclosure-and-reporting-1606916622_561176889.pdf"]

class My_credits {
  int _webinarId;
  String _webinarTitle;
  String _speakerName;
  String _credit;
  String _ceCredit;
  String _webinarCreditType;
  String _subject;
  String _webinarType;
  String _hostDate;
  String _webinarStatus;
  String _joinUrl;
  List<My_certificate_links> _myCertificateLinks;
  List<String> _certificateLink;

  int get webinarId => _webinarId;
  String get webinarTitle => _webinarTitle;
  String get speakerName => _speakerName;
  String get credit => _credit;
  String get ceCredit => _ceCredit;
  String get webinarCreditType => _webinarCreditType;
  String get subject => _subject;
  String get webinarType => _webinarType;
  String get hostDate => _hostDate;
  String get webinarStatus => _webinarStatus;
  String get joinUrl => _joinUrl;
  List<My_certificate_links> get myCertificateLinks => _myCertificateLinks;
  List<String> get certificateLink => _certificateLink;

  My_credits(
      {int webinarId,
      String webinarTitle,
      String speakerName,
      String credit,
      String ceCredit,
      String webinarCreditType,
      String subject,
      String webinarType,
      String hostDate,
      String webinarStatus,
      String joinUrl,
      List<My_certificate_links> myCertificateLinks,
      List<String> certificateLink}) {
    _webinarId = webinarId;
    _webinarTitle = webinarTitle;
    _speakerName = speakerName;
    _credit = credit;
    _ceCredit = ceCredit;
    _webinarCreditType = webinarCreditType;
    _subject = subject;
    _webinarType = webinarType;
    _hostDate = hostDate;
    _webinarStatus = webinarStatus;
    _joinUrl = joinUrl;
    _myCertificateLinks = myCertificateLinks;
    _certificateLink = certificateLink;
  }

  My_credits.fromJson(dynamic json) {
    _webinarId = json["webinar_id"];
    _webinarTitle = json["webinar_title"];
    _speakerName = json["speaker_name"];
    _credit = json["credit"];
    _ceCredit = json["ce_credit"];
    _webinarCreditType = json["webinar_credit_type"];
    _subject = json["subject"];
    _webinarType = json["webinar_type"];
    _hostDate = json["host_date"];
    _webinarStatus = json["webinar_status"];
    _joinUrl = json["joinUrl"];
    if (json["my_certificate_links"] != null) {
      _myCertificateLinks = [];
      json["my_certificate_links"].forEach((v) {
        _myCertificateLinks.add(My_certificate_links.fromJson(v));
      });
    }
    _certificateLink = json["certificate_link"] != null ? json["certificate_link"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["webinar_id"] = _webinarId;
    map["webinar_title"] = _webinarTitle;
    map["speaker_name"] = _speakerName;
    map["credit"] = _credit;
    map["ce_credit"] = _ceCredit;
    map["webinar_credit_type"] = _webinarCreditType;
    map["subject"] = _subject;
    map["webinar_type"] = _webinarType;
    map["host_date"] = _hostDate;
    map["webinar_status"] = _webinarStatus;
    map["joinUrl"] = _joinUrl;
    if (_myCertificateLinks != null) {
      map["my_certificate_links"] = _myCertificateLinks.map((v) => v.toJson()).toList();
    }
    map["certificate_link"] = _certificateLink;
    return map;
  }
}

/// certificate_type : "CPE"
/// certificate_link : "https://mycpe-image.s3-accelerate.amazonaws.com/certificate_backup/self_study_webinar/cpe/going-concern---implication-in-accountingdisclosure-and-reporting-1606916622_561176889.pdf"

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
