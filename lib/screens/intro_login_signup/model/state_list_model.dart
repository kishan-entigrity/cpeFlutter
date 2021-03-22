/// state : [{"id":2,"name":"Alabama"},{"id":1,"name":"Alaska"},{"id":4,"name":"Arizona"},{"id":3,"name":"Arkansas"},{"id":5,"name":"California"},{"id":53,"name":"Cokato"},{"id":6,"name":"Colorado"},{"id":7,"name":"Connecticut"},{"id":9,"name":"Delaware"},{"id":8,"name":"District of Columbia"},{"id":10,"name":"Florida"},{"id":11,"name":"Georgia"},{"id":12,"name":"Hawaii"},{"id":14,"name":"Idaho"},{"id":15,"name":"Illinois"},{"id":16,"name":"Indiana"},{"id":13,"name":"Iowa"},{"id":17,"name":"Kansas"},{"id":18,"name":"Kentucky"},{"id":19,"name":"Louisiana"},{"id":54,"name":"Lowa"},{"id":22,"name":"Maine"},{"id":21,"name":"Maryland"},{"id":20,"name":"Massachusetts"},{"id":55,"name":"Medfield"},{"id":23,"name":"Michigan"},{"id":4183,"name":"Minneapolis"},{"id":24,"name":"Minnesota"},{"id":26,"name":"Mississippi"},{"id":25,"name":"Missouri"},{"id":27,"name":"Montana"},{"id":30,"name":"Nebraska"},{"id":34,"name":"Nevada"},{"id":31,"name":"New Hampshire"},{"id":32,"name":"New Jersey"},{"id":33,"name":"New Mexico"},{"id":35,"name":"New York"},{"id":28,"name":"North Carolina"},{"id":29,"name":"North Dakota"},{"id":36,"name":"Ohio"},{"id":37,"name":"Oklahoma"},{"id":56,"name":"Ontario"},{"id":38,"name":"Oregon"},{"id":39,"name":"Pennsylvania"},{"id":40,"name":"Puerto Rico"},{"id":57,"name":"Ramey"},{"id":41,"name":"Rhode Island"},{"id":42,"name":"South Carolina"},{"id":43,"name":"South Dakota"},{"id":58,"name":"Sublimity"},{"id":44,"name":"Tennessee"},{"id":45,"name":"Texas"},{"id":59,"name":"Trimble"},{"id":46,"name":"Utah"},{"id":48,"name":"Vermont"},{"id":47,"name":"Virginia"},{"id":49,"name":"Washington"},{"id":51,"name":"West Virginia"},{"id":50,"name":"Wisconsin"},{"id":52,"name":"Wyoming"}]

class State_list_model {
  List<State_Name> _state;

  List<State_Name> get state => _state;

  State_list_model({List<State_Name> state}) {
    _state = state;
  }

  State_list_model.fromJson(dynamic json) {
    if (json["state"] != null) {
      _state = [];
      json["state"].forEach((v) {
        _state.add(State_Name.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_state != null) {
      map["state"] = _state.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// name : "Alabama"

class State_Name {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  State_Name({int id, String name}) {
    _id = id;
    _name = name;
  }

  State_Name.fromJson(dynamic json) {
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
