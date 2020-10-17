class Evenement {
  int id;
  String title;
  String description;
  DateTime date;
  int slots;
  bool is_private;
  // int user;

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.date = map['date'];
    this.description = map['description'];
    this.slots = map['slots'];
    this.is_private = map['is_private'];
    // this.user = map['user'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': this.title,
      'date': this.date,
      'description': this.description,
      'slots': this.slots,
      'is_private': this.is_private,
      // 'user': this.user
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
