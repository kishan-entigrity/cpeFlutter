// To parse this JSON data, do
//
//     final payload = payloadFromJson(jsonString);

import 'dart:convert';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  Payload({
    this.success,
    this.message,
    this.payload,
  });

  bool success;
  String message;
  PayloadClass payload;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    success: json["success"],
    message: json["message"],
    payload: PayloadClass.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "payload": payload.toJson(),
  };
}

class PayloadClass {
  PayloadClass({
    this.webinar,
    this.isProgress,
    this.recentWebinars,
    this.isLast,
  });

  List<Webinar> webinar;
  bool isProgress;
  List<RecentWebinar> recentWebinars;
  bool isLast;

  factory PayloadClass.fromJson(Map<String, dynamic> json) => PayloadClass(
    webinar: List<Webinar>.from(json["webinar"].map((x) => Webinar.fromJson(x))),
    isProgress: json["is_progress"],
    recentWebinars: List<RecentWebinar>.from(json["RecentWebinars"].map((x) => RecentWebinar.fromJson(x))),
    isLast: json["is_last"],
  );

  Map<String, dynamic> toJson() => {
    "webinar": List<dynamic>.from(webinar.map((x) => x.toJson())),
    "is_progress": isProgress,
    "RecentWebinars": List<dynamic>.from(recentWebinars.map((x) => x.toJson())),
    "is_last": isLast,
  };
}

class RecentWebinar {
  RecentWebinar({
    this.id,
    this.webinarTitle,
    this.webinarType,
    this.webinarImage,
  });

  int id;
  String webinarTitle;
  String webinarType;
  String webinarImage;

  factory RecentWebinar.fromJson(Map<String, dynamic> json) => RecentWebinar(
    id: json["id"],
    webinarTitle: json["webinar_title"],
    webinarType: json["webinar_type"],
    webinarImage: json["webinar_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "webinar_title": webinarTitle,
    "webinar_type": webinarType,
    "webinar_image": webinarImage,
  };
}

class Webinar {
  Webinar({
    this.id,
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
    this.isCardSave,
  });

  int id;
  String webinarTitle;
  WebinarType webinarType;
  String speakerName;
  CpaCredit cpaCredit;
  Fee fee;
  String tierName;
  String productId;
  String paymentLink;
  int scheduleId;
  String startDate;
  String startTime;
  String timeZone;
  Status status;
  String joinUrl;
  bool isCardSave;

  factory Webinar.fromJson(Map<String, dynamic> json) => Webinar(
    id: json["id"],
    webinarTitle: json["webinar_title"],
    webinarType: webinarTypeValues.map[json["webinar_type"]],
    speakerName: json["speaker_name"],
    cpaCredit: cpaCreditValues.map[json["cpa_credit"]],
    fee: feeValues.map[json["fee"]],
    tierName: json["tier_name"],
    productId: json["product_id"],
    paymentLink: json["payment_link"],
    scheduleId: json["schedule_id"],
    startDate: json["start_date"],
    startTime: json["start_time"],
    timeZone: json["time_zone"],
    status: statusValues.map[json["status"]],
    joinUrl: json["join_url"],
    isCardSave: json["is_card_save"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "webinar_title": webinarTitle,
    "webinar_type": webinarTypeValues.reverse[webinarType],
    "speaker_name": speakerName,
    "cpa_credit": cpaCreditValues.reverse[cpaCredit],
    "fee": feeValues.reverse[fee],
    "tier_name": tierName,
    "product_id": productId,
    "payment_link": paymentLink,
    "schedule_id": scheduleId,
    "start_date": startDate,
    "start_time": startTime,
    "time_zone": timeZone,
    "status": statusValues.reverse[status],
    "join_url": joinUrl,
    "is_card_save": isCardSave,
  };
}

enum CpaCredit { THE_1_CPE, THE_15_CPE }

final cpaCreditValues = EnumValues({
  "1.5 CPE": CpaCredit.THE_15_CPE,
  "1 CPE": CpaCredit.THE_1_CPE
});

enum Fee { FREE }

final feeValues = EnumValues({
  "FREE": Fee.FREE
});

enum Status { REGISTER, RESUME_WATCHING }

final statusValues = EnumValues({
  "Register": Status.REGISTER,
  "Resume Watching": Status.RESUME_WATCHING
});

enum WebinarType { ON_DEMAND }

final webinarTypeValues = EnumValues({
  "ON-DEMAND": WebinarType.ON_DEMAND
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
