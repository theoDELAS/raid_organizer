class User {
  int id;
  String username;
  String image;
  String mail;
  String password;

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.username = map['username'];
    this.image = map['image'];
    this.mail = map['mail'];
    this.password = map['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'username': this.username,
      'image': this.image,
      'mail': this.mail,
      'password': this.password,
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
