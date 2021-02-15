class modelWebList {
  bool success;
  String message;
  Payload payload;

  modelWebList({this.success, this.message, this.payload});

  modelWebList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    payload = json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload.toJson();
    }
    return data;
  }
}

class Payload {
  List<Webinar> webinar;
  bool isProgress;
  List<RecentWebinars> recentWebinars;
  bool isLast;

  Payload({this.webinar, this.isProgress, this.recentWebinars, this.isLast});

  Payload.fromJson(Map<String, dynamic> json) {
    if (json['webinar'] != null) {
      webinar = new List<Webinar>();
      json['webinar'].forEach((v) {
        webinar.add(new Webinar.fromJson(v));
      });
    }
    isProgress = json['is_progress'];
    if (json['RecentWebinars'] != null) {
      recentWebinars = new List<RecentWebinars>();
      json['RecentWebinars'].forEach((v) {
        recentWebinars.add(new RecentWebinars.fromJson(v));
      });
    }
    isLast = json['is_last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.webinar != null) {
      data['webinar'] = this.webinar.map((v) => v.toJson()).toList();
    }
    data['is_progress'] = this.isProgress;
    if (this.recentWebinars != null) {
      data['RecentWebinars'] = this.recentWebinars.map((v) => v.toJson()).toList();
    }
    data['is_last'] = this.isLast;
    return data;
  }
}

class Webinar {
  int id;
  String webinarTitle;
  String webinarType;
  String speakerName;
  String cpaCredit;
  String fee;
  String tierName;
  String productId;
  String paymentLink;
  int scheduleId;
  String startDate;
  String startTime;
  String timeZone;
  String status;
  String joinUrl;
  bool isCardSave;

  Webinar(
      {this.id,
      this.webinarTitle,
      this.webinarType,
      this.speakerName,
      this.cpaCredit,
      this.fee,
      this.tierName,
      this.productId,
      this.paymentLink,
      this.scheduleId,
      this.startDate,
      this.startTime,
      this.timeZone,
      this.status,
      this.joinUrl,
      this.isCardSave});

  Webinar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webinarTitle = json['webinar_title'];
    webinarType = json['webinar_type'];
    speakerName = json['speaker_name'];
    cpaCredit = json['cpa_credit'];
    fee = json['fee'];
    tierName = json['tier_name'];
    productId = json['product_id'];
    paymentLink = json['payment_link'];
    scheduleId = json['schedule_id'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    timeZone = json['time_zone'];
    status = json['status'];
    joinUrl = json['join_url'];
    isCardSave = json['is_card_save'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['webinar_title'] = this.webinarTitle;
    data['webinar_type'] = this.webinarType;
    data['speaker_name'] = this.speakerName;
    data['cpa_credit'] = this.cpaCredit;
    data['fee'] = this.fee;
    data['tier_name'] = this.tierName;
    data['product_id'] = this.productId;
    data['payment_link'] = this.paymentLink;
    data['schedule_id'] = this.scheduleId;
    data['start_date'] = this.startDate;
    data['start_time'] = this.startTime;
    data['time_zone'] = this.timeZone;
    data['status'] = this.status;
    data['join_url'] = this.joinUrl;
    data['is_card_save'] = this.isCardSave;
    return data;
  }
}

class RecentWebinars {
  int id;
  String webinarTitle;
  String webinarType;
  String webinarImage;

  RecentWebinars({this.id, this.webinarTitle, this.webinarType, this.webinarImage});

  RecentWebinars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webinarTitle = json['webinar_title'];
    webinarType = json['webinar_type'];
    webinarImage = json['webinar_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['webinar_title'] = this.webinarTitle;
    data['webinar_type'] = this.webinarType;
    data['webinar_image'] = this.webinarImage;
    return data;
  }
}
