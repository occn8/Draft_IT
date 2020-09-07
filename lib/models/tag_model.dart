class Tag {
  int id;
  String name;
  Tag(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = name;

    return map;
  }

  Tag.fromMapOject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
  }
}
