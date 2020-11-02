import 'package:flutter/material.dart';

class Evenement extends ChangeNotifier {
  int id;
  String title;
  String description;
  DateTime date;
  String slots;
  bool is_private;
  String game_id;
  // int user;

  fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.date = map['date'];
    this.description = map['description'];
    this.slots = map['slots'];
    this.game_id = map['game_id'];
    // this.is_private = map['is_private'];
    // this.user = map['user'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': this.title,
      'date': this.date,
      'description': this.description,
      'slots': this.slots,
      'game_id': this.game_id
      // 'is_private': this.is_private,
      // 'user': this.user
    };
    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}
