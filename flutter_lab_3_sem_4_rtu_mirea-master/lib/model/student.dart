class Student {
  int _id;
  String _name;
  String _addedtime;
 
  Student(this._name, this._addedtime);
 
  Student.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._addedtime = obj['addedtime'];
  }
 
  int get id => _id;
  String get name => _name;
  String get addeddate => _addedtime;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['addedtime'] = _addedtime;
 
    return map;
  }
 
  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._addedtime = map['addedtime'];
  }
}