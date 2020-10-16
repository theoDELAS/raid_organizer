class Game {
  int id;
  String name;
  String image;
  String description;

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
    this.description = map['description'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': this.name,
      'image': this.image,
      'description': this.description
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
