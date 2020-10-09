import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/game.dart';

class GameDetail extends StatefulWidget {
  Game game;

  GameDetail(Game game) {
    this.game = game;
  }

  @override
  _GameDetailState createState() => new _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
    );
  }
}