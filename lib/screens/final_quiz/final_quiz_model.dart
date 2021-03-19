/// final_quiz_questions : [{"id":84471,"question_title":"Which one of the following represent the pillars of the structure of the credit card industry that takes the most risk in the credit card transactions?","answer":"c","a":{"option_title":"Issuing Banks.","is_answer":"false"},"b":{"option_title":"Independent Sales Organizations or ISO.","is_answer":"false"},"c":{"option_title":"Acquiring Banks.","is_answer":"true"},"d":{"option_title":"Both A and B.","is_answer":"false"}},{"id":84472,"question_title":"How much potential saving a merchant account auditing can help a regular substantial credit card user on an average?","answer":"c","a":{"option_title":"20 to 30%.","is_answer":"false"},"b":{"option_title":"30 to 35%.","is_answer":"false"},"c":{"option_title":"25 to 35%.","is_answer":"true"},"d":{"option_title":"20 to 35%.","is_answer":"false"}},{"id":84473,"question_title":"Which one of the following is the thing you would want to know before you start surcharging?","answer":"d","a":{"option_title":"Whether you are allowed to surcharge.","is_answer":"false"},"b":{"option_title":"Which are the rules you need to follow for being able to surcharge customers?","is_answer":"false"},"c":{"option_title":"How average customer feels about credit card surcharging in your industry?","is_answer":"false"},"d":{"option_title":"All of A, B, and C.","is_answer":"true"}},{"id":84474,"question_title":"Which one of the following is one of the DIYs increase your credit card with an additional layer of security?","answer":"a","a":{"option_title":"Insert the chip/swipe the card.","is_answer":"true"},"b":{"option_title":"Avoid leasing your terminal.","is_answer":"false"},"c":{"option_title":"Avoid voice authorization.","is_answer":"false"},"d":{"option_title":"Keep a strict monitor on your gateway.","is_answer":"false"}},{"id":84475,"question_title":"Which one of the following is the benefit of the gain share billing from merchant account auditing?","answer":"d","a":{"option_title":"Fees are charged if the savings are archived.","is_answer":"false"},"b":{"option_title":"Merchant account auditing provides continued auditing cadence","is_answer":"false"},"c":{"option_title":"Merchant account savings are paid on the variable saving basis","is_answer":"false"},"d":{"option_title":"All of A, B, and C.","is_answer":"true"}}]

class Final_quiz_model {
  List<Final_quiz_questions> _finalQuizQuestions;

  List<Final_quiz_questions> get finalQuizQuestions => _finalQuizQuestions;

  Final_quiz_model({List<Final_quiz_questions> finalQuizQuestions}) {
    _finalQuizQuestions = finalQuizQuestions;
  }

  Final_quiz_model.fromJson(dynamic json) {
    if (json["final_quiz_questions"] != null) {
      _finalQuizQuestions = [];
      json["final_quiz_questions"].forEach((v) {
        _finalQuizQuestions.add(Final_quiz_questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_finalQuizQuestions != null) {
      map["final_quiz_questions"] = _finalQuizQuestions.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 84471
/// question_title : "Which one of the following represent the pillars of the structure of the credit card industry that takes the most risk in the credit card transactions?"
/// answer : "c"
/// a : {"option_title":"Issuing Banks.","is_answer":"false"}
/// b : {"option_title":"Independent Sales Organizations or ISO.","is_answer":"false"}
/// c : {"option_title":"Acquiring Banks.","is_answer":"true"}
/// d : {"option_title":"Both A and B.","is_answer":"false"}

class Final_quiz_questions {
  int _id;
  String _questionTitle;
  String _answer;
  A _a;
  B _b;
  C _c;
  D _d;
  bool _isAnswered = false;
  bool _isCorrectAnswered = false;
  bool _isAnswerUpdated = false;
  String _answeredOption;

  int get id => _id;
  String get questionTitle => _questionTitle;
  String get answer => _answer;
  bool get isAnswered => _isAnswered;
  bool get isCorrectAnswered => _isCorrectAnswered;
  bool get isAnswerUpdated => _isAnswerUpdated;
  String get answeredOption => _answeredOption;
  A get a => _a;
  B get b => _b;
  C get c => _c;
  D get d => _d;

  set isAnswered(bool isAnswered) {
    this._isAnswered = isAnswered;
  }

  set isCorrectAnswered(bool isCorrectAnswered) {
    this._isCorrectAnswered = isCorrectAnswered;
  }

  set isAnswerUpdated(bool isAnswerUpdated) {
    this._isAnswerUpdated = isAnswerUpdated;
  }

  set answeredOption(String answeredOption) {
    this._answeredOption = answeredOption;
  }

  Final_quiz_questions({int id, String questionTitle, String answer, A a, B b, C c, D d}) {
    _id = id;
    _questionTitle = questionTitle;
    _answer = answer;
    _a = a;
    _b = b;
    _c = c;
    _d = d;
  }

  Final_quiz_questions.fromJson(dynamic json) {
    _id = json["id"];
    _questionTitle = json["question_title"];
    _answer = json["answer"];
    _a = json["a"] != null ? A.fromJson(json["a"]) : null;
    _b = json["b"] != null ? B.fromJson(json["b"]) : null;
    _c = json["c"] != null ? C.fromJson(json["c"]) : null;
    _d = json["d"] != null ? D.fromJson(json["d"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["question_title"] = _questionTitle;
    map["answer"] = _answer;
    if (_a != null) {
      map["a"] = _a.toJson();
    }
    if (_b != null) {
      map["b"] = _b.toJson();
    }
    if (_c != null) {
      map["c"] = _c.toJson();
    }
    if (_d != null) {
      map["d"] = _d.toJson();
    }
    return map;
  }
}

/// option_title : "Both A and B."
/// is_answer : "false"

class D {
  String _optionTitle;
  String _isAnswer;

  String get optionTitle => _optionTitle;
  String get isAnswer => _isAnswer;

  D({String optionTitle, String isAnswer}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
  }

  D.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    return map;
  }
}

/// option_title : "Acquiring Banks."
/// is_answer : "true"

class C {
  String _optionTitle;
  String _isAnswer;

  String get optionTitle => _optionTitle;
  String get isAnswer => _isAnswer;

  C({String optionTitle, String isAnswer}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
  }

  C.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    return map;
  }
}

/// option_title : "Independent Sales Organizations or ISO."
/// is_answer : "false"

class B {
  String _optionTitle;
  String _isAnswer;

  String get optionTitle => _optionTitle;
  String get isAnswer => _isAnswer;

  B({String optionTitle, String isAnswer}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
  }

  B.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    return map;
  }
}

/// option_title : "Issuing Banks."
/// is_answer : "false"

class A {
  String _optionTitle;
  String _isAnswer;

  String get optionTitle => _optionTitle;
  String get isAnswer => _isAnswer;

  A({String optionTitle, String isAnswer}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
  }

  A.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    return map;
  }
}
