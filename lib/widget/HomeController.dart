import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'dart:async';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/CarouselController.dart' as carousel;
import 'package:raid_organizer/widget/appBar.dart';
import 'package:raid_organizer/widget/EventFriendCardController.dart';

import 'appBar.dart';

class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  String newList;
  List<Game> games;

  String name;
  String image;
  String description;

  @override
  void initState() {
    super.initState();
    DatabaseClient().showGames().then((value) {
      setState(() {
        games = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              FlatButton(
                color: Colors.grey,
                onPressed: (() => add(null)),
                child: Text(
                  "Ajouter",
                  style: TextStyle(color: Colors.white, fontFamily: 'Jost'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 196, 131, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                    ),
                    carousel.VerticalDivider(30),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Ma Liste',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Jost',
                                  color: Colors.white),
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // do something
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (games == null || games.length == 0)
                  ? Text("Vous n'avez pas de jeu dans votre liste.",
                      style: TextStyle(color: Colors.redAccent))
                  : carousel.Carousel(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(2, 196, 131, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text(
                  'EVENTS AMIS',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Jost'),
                ),
              ),
              EventFriendCard(),
            ],
          ),
        ));
  }

  Future<Null> add(Game game) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext buildContext) {
          return AlertDialog(
              title: Text('Ajouter un jeu'),
              content: Card(
                  child: Column(children: <Widget>[
                myTextField(TypeTextField.name, "Nom du jeu"),
                myTextField(TypeTextField.image, "Image du jeu"),
                myTextField(TypeTextField.description, "Description du jeu"),
              ])),
              actions: <Widget>[
                FlatButton(
                    onPressed: (() => Navigator.pop(buildContext)),
                    child: Text('Annuler')),
                FlatButton(
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
                      Game game = new Game();
                      game.fromMap(map);
                      DatabaseClient().upsertGame(game).then((value) {
                        name = null;
                        image = null;
                        description = null;
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    'Valider',
                    style: TextStyle(
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
