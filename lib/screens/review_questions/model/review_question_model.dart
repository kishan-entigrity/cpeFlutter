/// review_questions : [{"id":3122,"question_title":"Which is NOT a S.A.V.E.R. recommendation?","answer":"d","a":{"option_title":"Silence","is_answer":"false","description":"Silence is a great way for meditation time."},"b":{"option_title":"Visualization","is_answer":"false","description":"Visualization is a great way to visualize your day and/or your future."},"c":{"option_title":"Scribing","is_answer":"false","description":"Scribing is a way of journaling your thoughts of the morning/gratitude list."},"d":{"option_title":"Eating","is_answer":"true","description":"Eating is not a S.A.V.E.R. recommendation."}},{"id":3123,"question_title":"According to Asher, which R.R.A.F.T. letter is the MOST important?","answer":"a","a":{"option_title":"Reason","is_answer":"true","description":"A strong reason/WHY will pull you through the challenges and brings clarity on the HOW/ACTIONS."},"b":{"option_title":"Result","is_answer":"false","description":"Your result is easy to convey when you know what you want."},"c":{"option_title":"Action","is_answer":"false","description":"To know what actions are best, a strong WHY is needed to pull you toward the result."},"d":{"option_title":"Thrill","is_answer":"false","description":"An added thrill to your goal is easy to add."}}]

class Review_question_model {
  List<Review_questions> _reviewQuestions;

  List<Review_questions> get reviewQuestions => _reviewQuestions;

  Review_question_model({List<Review_questions> reviewQuestions}) {
    _reviewQuestions = reviewQuestions;
  }

  Review_question_model.fromJson(dynamic json) {
    if (json["review_questions"] != null) {
      _reviewQuestions = [];
      json["review_questions"].forEach((v) {
        _reviewQuestions.add(Review_questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_reviewQuestions != null) {
      map["review_questions"] = _reviewQuestions.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3122
/// question_title : "Which is NOT a S.A.V.E.R. recommendation?"
/// answer : "d"
/// a : {"option_title":"Silence","is_answer":"false","description":"Silence is a great way for meditation time."}
/// b : {"option_title":"Visualization","is_answer":"false","description":"Visualization is a great way to visualize your day and/or your future."}
/// c : {"option_title":"Scribing","is_answer":"false","description":"Scribing is a way of journaling your thoughts of the morning/gratitude list."}
/// d : {"option_title":"Eating","is_answer":"true","description":"Eating is not a S.A.V.E.R. recommendation."}

class Review_questions {
  int _id;
  String _questionTitle;
  String _answer;
  A _a;
  B _b;
  C _c;
  D _d;
  bool _isAnswered = false;
  bool _isCorrectAnswered = false;
  String _answeredOption;

  int get id => _id;

  String get questionTitle => _questionTitle;

  String get answer => _answer;

  bool get isAnswered => _isAnswered;

  bool get isCorrectAnswered => _isCorrectAnswered;

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

  set answeredOption(String answeredOption) {
    this._answeredOption = answeredOption;
  }

  Review_questions({int id, String questionTitle, String answer, A a, B b, C c, D d}) {
    _id = id;
    _questionTitle = questionTitle;
    _answer = answer;
    _a = a;
    _b = b;
    _c = c;
    _d = d;
  }

  Review_questions.fromJson(dynamic json) {
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

/// option_title : "Eating"
/// is_answer : "true"
/// description : "Eating is not a S.A.V.E.R. recommendation."

class D {
  String _optionTitle;
  String _isAnswer;
  String _description;

  String get optionTitle => _optionTitle;

  String get isAnswer => _isAnswer;

  String get description => _description;

  set optionTitle(String optionTitle) {
    this._optionTitle = optionTitle;
  }

  set isAnswer(String isAnswer) {
    this._isAnswer = isAnswer;
  }

  set description(String description) {
    this._description = description;
  }

  D({String optionTitle, String isAnswer, String description}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
    _description = description;
  }

  D.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    map["description"] = _description;
    return map;
  }
}

/// option_title : "Scribing"
/// is_answer : "false"
/// description : "Scribing is a way of journaling your thoughts of the morning/gratitude list."

class C {
  String _optionTitle;
  String _isAnswer;
  String _description;

  String get optionTitle => _optionTitle;

  String get isAnswer => _isAnswer;

  String get description => _description;

  set optionTitle(String optionTitle) {
    this._optionTitle = optionTitle;
  }

  set isAnswer(String isAnswer) {
    this._isAnswer = isAnswer;
  }

  set description(String description) {
    this._description = description;
  }

  C({String optionTitle, String isAnswer, String description}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
    _description = description;
  }

  C.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    map["description"] = _description;
    return map;
  }
}

/// option_title : "Visualization"
/// is_answer : "false"
/// description : "Visualization is a great way to visualize your day and/or your future."

class B {
  String _optionTitle;
  String _isAnswer;
  String _description;

  String get optionTitle => _optionTitle;

  String get isAnswer => _isAnswer;

  String get description => _description;

  set optionTitle(String optionTitle) {
    this._optionTitle = optionTitle;
  }

  set isAnswer(String isAnswer) {
    this._isAnswer = isAnswer;
  }

  set description(String description) {
    this._description = description;
  }

  B({String optionTitle, String isAnswer, String description}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
    _description = description;
  }

  B.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    map["description"] = _description;
    return map;
  }
}

/// option_title : "Silence"
/// is_answer : "false"
/// description : "Silence is a great way for meditation time."

class A {
  String _optionTitle;
  String _isAnswer;
  String _description;

  String get optionTitle => _optionTitle;

  String get isAnswer => _isAnswer;

  String get description => _description;

  set optionTitle(String optionTitle) {
    this._optionTitle = optionTitle;
  }

  set isAnswer(String isAnswer) {
    this._isAnswer = isAnswer;
  }

  set description(String description) {
    this._description = description;
  }

  A({String optionTitle, String isAnswer, String description}) {
    _optionTitle = optionTitle;
    _isAnswer = isAnswer;
    _description = description;
  }

  A.fromJson(dynamic json) {
    _optionTitle = json["option_title"];
    _isAnswer = json["is_answer"];
    _description = json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["option_title"] = _optionTitle;
    map["is_answer"] = _isAnswer;
    map["description"] = _description;
    return map;
  }
}
