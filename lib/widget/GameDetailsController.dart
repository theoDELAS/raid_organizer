import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:flutter/cupertino.dart';

import 'appBar.dart';

class GameDetailsController extends StatefulWidget {
  Game game;

  GameDetailsController(Game game) {
    this.game = game;
  }

  @override
  _GameDetailsControllerState createState() => _GameDetailsControllerState();
}

class _GameDetailsControllerState extends State<GameDetailsController> {
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
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            GestureDetector(
              child: Container(
                width: 400,
                height: 200,
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
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.game.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 27,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 20),
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.game.description,
                  style: TextStyle(color: Colors.grey[850], fontSize: 17),
                )),
            Row(children: <Widget>[
              FlatButton(
                  color: Colors.blue[800],
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(5.0),
                  splashColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.blue)),
                  onPressed: (() => update(widget.game)),
                  child: Text(
                    "MODIFIER",
                    style: TextStyle(fontSize: 15, fontFamily: 'Jost'),
                  )),
              FlatButton(
                color: Colors.red[800],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(5.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.red)),
                onPressed: (() {
                  DatabaseClient().deleteGame(widget.game.id, 'game');
                }),
                child: Text(
                  "SUPPRIMER",
                  style: TextStyle(fontSize: 15, fontFamily: 'Jost'),
                ),
              ),
            ])
          ]),
        ));
  }

  Future<Null> update(Game game) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return new CupertinoAlertDialog(
              title: new Text('Modifier ${game.name}'),
              content: Card(
                  child: Column(children: <Widget>[
                myTextField(TypeTextField.name, "Nom du jeu"),
                myTextField(TypeTextField.image, "Image du jeu"),
                myTextField(TypeTextField.description, "Description du jeu"),
              ])),
              actions: <Widget>[
                new FlatButton(
                    onPressed: (() => Navigator.pop(buildContext)),
                    child: new Text('Annuler')),
                new FlatButton(
                  onPressed: () {
                    // Ajouter à la base de données
                    if (name != null) {
                      Map<String, dynamic> map = {'name': name};
                      if (image != null) {
                        map['image'] = image;
                      }
                      if (description != null) {
                        map['description'] = description;
                      }
                      game.fromMap(map);
                      DatabaseClient().upsertGame(game).then((value) {
                        name = null;
                        image = null;
                        description = null;
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: new Text(
                    'Valider',
                    style: new TextStyle(
                      color: Colors.green,
                    ),
                  ),
                )
              ]);
        });
  }

  TextField myTextField(TypeTextField type, String label) {
    return TextField(
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.name:
            name = string;
            break;
          case TypeTextField.image:
            image = string;
            break;
          case TypeTextField.description:
            description = string;
            break;
        }
      },
    );
  }

  void getGames() {
    DatabaseClient().showGames().then((games) {
      setState(() {
        this.games = games;
      });
    });
  }
}

enum TypeTextField { name, image, description }
