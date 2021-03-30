/// saved_cards : [{"id":2330,"card_holder_name":"test","card_last_number":"2345","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"khkDKtPoxoa7gmMdKGL2Gtvv0HKSKW4i","iv":"9mBhf0HKGd0E4nzY","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-17 08:35:08","updated_at":"2021-03-17 08:35:08","deleted_at":null,"expire_month":"08","expire_year":"23"},{"id":2289,"card_holder_name":"Rakesh singh","card_last_number":"3455","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"S97rOq9ObyBBnYUX3mArFs9l4dSC1tP6","iv":"NadUcolYoKRgNRRj","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:29:52","updated_at":"2021-03-16 15:29:52","deleted_at":null,"expire_month":"09","expire_year":"24"},{"id":2286,"card_holder_name":"Rakesh singh","card_last_number":"3456","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"Sw1AxdK7SjxvInOwsYJ2C6jchX28gT2W","iv":"icyXKGZSBcWdi44k","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:18:04","updated_at":"2021-03-16 15:18:04","deleted_at":null,"expire_month":"07","expire_year":"27"},{"id":2285,"card_holder_name":"Rakesh singh","card_last_number":"4545","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"JBHDaREpngVtSluXx2eK5XtptWjd9Bnd","iv":"WVKWJAZqiEegxRDq","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:17:00","updated_at":"2021-03-16 15:17:00","deleted_at":null,"expire_month":"07","expire_year":"26"},{"id":2284,"card_holder_name":"Rakesh singh","card_last_number":"4545","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"Mn4ZdDrBNicExVTIAl5KnOrBQJjzJzAp","iv":"C0ofkAmBSWKrFxPL","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:16:57","updated_at":"2021-03-16 15:16:57","deleted_at":null,"expire_month":"07","expire_year":"26"},{"id":2283,"card_holder_name":"Rakesh singh","card_last_number":"5454","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"2SgsDE2MgRP2LhRkiycaT4pstUk0j7WK","iv":"7P0qi4EhMiIoXMd9","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:16:43","updated_at":"2021-03-16 15:16:43","deleted_at":null,"expire_month":"07","expire_year":"26"},{"id":2282,"card_holder_name":"Rakesh singh","card_last_number":"1215","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"0QsU0BzYCeEjlA4xGOqRQC0y56hv8bXh","iv":"Y91fIn9cAzQ6o4fR","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:16:07","updated_at":"2021-03-16 15:16:07","deleted_at":null,"expire_month":"08","expire_year":"25"},{"id":2281,"card_holder_name":"Rakesh singh","card_last_number":"2121","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"FCOr1I1I180GlpNkwUuX9JH9Ezq5VFqB","iv":"bFEJBfA3bUT1J0s5","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 15:15:50","updated_at":"2021-03-16 15:15:50","deleted_at":null,"expire_month":"08","expire_year":"25"},{"id":2246,"card_holder_name":"Rakesh singh","card_last_number":"0018","user_id":45492,"user_password":"$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm","inputKey":"YuWat7X64UQlnGbLndyGWowPd2bkLM7P","iv":"tpOXxcKRUgkzRhbi","blockSize":"256","default_card":"0","is_saved":1,"created_at":"2021-03-16 12:58:27","updated_at":"2021-03-19 14:58:52","deleted_at":null,"expire_month":"03","expire_year":"24"}]

class User_cards_list {
  List<Saved_cards> _savedCards;

  List<Saved_cards> get savedCards => _savedCards;

  User_cards_list({List<Saved_cards> savedCards}) {
    _savedCards = savedCards;
  }

  User_cards_list.fromJson(dynamic json) {
    if (json["saved_cards"] != null) {
      _savedCards = [];
      json["saved_cards"].forEach((v) {
        _savedCards.add(Saved_cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_savedCards != null) {
      map["saved_cards"] = _savedCards.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2330
/// card_holder_name : "test"
/// card_last_number : "2345"
/// user_id : 45492
/// user_password : "$2y$10$Q/GS/HVx3UHv7jXgjCk9fO/a3YdCzAWc/zvfApvIJJQ1GcpglFHhm"
/// inputKey : "khkDKtPoxoa7gmMdKGL2Gtvv0HKSKW4i"
/// iv : "9mBhf0HKGd0E4nzY"
/// blockSize : "256"
/// default_card : "0"
/// is_saved : 1
/// created_at : "2021-03-17 08:35:08"
/// updated_at : "2021-03-17 08:35:08"
/// deleted_at : null
/// expire_month : "08"
/// expire_year : "23"

class Saved_cards {
  int _id;
  String _cardHolderName;
  String _cardLastNumber;
  int _userId;
  String _userPassword;
  String _inputKey;
  String _iv;
  String _blockSize;
  String _defaultCard;
  int _isSaved;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  String _expireMonth;
  String _expireYear;

  int get id => _id;
  String get cardHolderName => _cardHolderName;
  String get cardLastNumber => _cardLastNumber;
  int get userId => _userId;
  String get userPassword => _userPassword;
  String get inputKey => _inputKey;
  String get iv => _iv;
  String get blockSize => _blockSize;
  String get defaultCard => _defaultCard;
  int get isSaved => _isSaved;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String get expireMonth => _expireMonth;
  String get expireYear => _expireYear;

  set defaultCard(String defaultCard) {
    this._defaultCard = defaultCard;
  }

  Saved_cards(
      {int id,
      String cardHolderName,
      String cardLastNumber,
      int userId,
      String userPassword,
      String inputKey,
      String iv,
      String blockSize,
      String defaultCard,
      int isSaved,
      String createdAt,
      String updatedAt,
      dynamic deletedAt,
      String expireMonth,
      String expireYear}) {
    _id = id;
    _cardHolderName = cardHolderName;
    _cardLastNumber = cardLastNumber;
    _userId = userId;
    _userPassword = userPassword;
    _inputKey = inputKey;
    _iv = iv;
    _blockSize = blockSize;
    _defaultCard = defaultCard;
    _isSaved = isSaved;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _expireMonth = expireMonth;
    _expireYear = expireYear;
  }

  Saved_cards.fromJson(dynamic json) {
    _id = json["id"];
    _cardHolderName = json["card_holder_name"];
    _cardLastNumber = json["card_last_number"];
    _userId = json["user_id"];
    _userPassword = json["user_password"];
    _inputKey = json["inputKey"];
    _iv = json["iv"];
    _blockSize = json["blockSize"];
    _defaultCard = json["default_card"];
    _isSaved = json["is_saved"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    _expireMonth = json["expire_month"];
    _expireYear = json["expire_year"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["card_holder_name"] = _cardHolderName;
    map["card_last_number"] = _cardLastNumber;
    map["user_id"] = _userId;
    map["user_password"] = _userPassword;
    map["inputKey"] = _inputKey;
    map["iv"] = _iv;
    map["blockSize"] = _blockSize;
    map["default_card"] = _defaultCard;
    map["is_saved"] = _isSaved;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    map["expire_month"] = _expireMonth;
    map["expire_year"] = _expireYear;
    return map;
  }
}
