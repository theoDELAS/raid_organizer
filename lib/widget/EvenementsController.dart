import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:raid_organizer/widget/GameDetailsController.dart';
import 'package:raid_organizer/widget/HomeController.dart';

import 'appBar.dart';

class EvenementsController extends StatefulWidget {
  Game game;

  EvenementsController(Game game) {
    this.game = game;
  }

  @override
  _EvenementsControllerState createState() => _EvenementsControllerState();
}

class _EvenementsControllerState extends State<EvenementsController> {
  @override
  void initState() {
    super.initState();
    getGames();
  }

  String newList;
  List<Game> games;

  String name;
  String image;
  String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            FlatButton(
              onPressed: (() => HomeController()),
              child: Text(
                "Créer un évènement",
                style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
              ),
              color: Color.fromRGBO(2, 196, 131, 1),
              textColor: Colors.white,
              padding: EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext buildContext) {
                  return GameDetailsController(widget.game);
                }));
              },
            ),
            SizedBox(height: 30),
            Text(
                "Mes évènements ".toUpperCase() +
                    widget.game.name.toUpperCase(),
                style: TextStyle(fontSize: 26, fontFamily: 'Jost')),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                width: 370,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ],
                    image: DecorationImage(
                      image: NetworkImage(widget.game.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    )),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Activités en cours".toUpperCase(),
              style: TextStyle(fontSize: 26, fontFamily: 'Jost'),
            ),
          ],
        )));
  }

  void getGames() {
    DatabaseClient().showGames().then((games) {
      setState(() {
        this.games = games;
      });
    });
  }
}
