/// webinar_testimonial : [{"rate":5,"first_name":"Rachel","last_name":"Adelsen","designation":", ","date":"October 9th 2020","review":"Thank you!"},{"rate":5,"first_name":"Pamellia","last_name":"Anthony","designation":", ","date":"October 9th 2020","review":"I appreciate this class because it’s not my strength. The instructor and his examples were good along with the handout. Great Q&A at the end of the session. Appreciate that he wasn’t trying to sell something.?"},{"rate":5,"first_name":"Nicholas","last_name":"Caviolo","designation":", ","date":"December 11th 2020","review":"Good"}]

class Testimonials_list {
  List<Webinar_testimonial> _webinarTestimonial;

  List<Webinar_testimonial> get webinarTestimonial => _webinarTestimonial;

  Testimonials_list({List<Webinar_testimonial> webinarTestimonial}) {
    _webinarTestimonial = webinarTestimonial;
  }

  Testimonials_list.fromJson(dynamic json) {
    if (json["webinar_testimonial"] != null) {
      _webinarTestimonial = [];
      json["webinar_testimonial"].forEach((v) {
        _webinarTestimonial.add(Webinar_testimonial.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_webinarTestimonial != null) {
      map["webinar_testimonial"] = _webinarTestimonial.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// rate : 5
/// first_name : "Rachel"
/// last_name : "Adelsen"
/// designation : ", "
/// date : "October 9th 2020"
/// review : "Thank you!"

class Webinar_testimonial {
  int _rate;
  String _firstName;
  String _lastName;
  String _designation;
  String _date;
  String _review;

  int get rate => _rate;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get designation => _designation;
  String get date => _date;
  String get review => _review;

  Webinar_testimonial({int rate, String firstName, String lastName, String designation, String date, String review}) {
    _rate = rate;
    _firstName = firstName;
    _lastName = lastName;
    _designation = designation;
    _date = date;
    _review = review;
  }

  Webinar_testimonial.fromJson(dynamic json) {
    _rate = json["rate"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _designation = json["designation"];
    _date = json["date"];
    _review = json["review"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rate"] = _rate;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["designation"] = _designation;
    map["date"] = _date;
    map["review"] = _review;
    return map;
  }
}
