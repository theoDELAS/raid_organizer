import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'dart:async';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/CarouselController.dart' as carousel;
import 'package:raid_organizer/widget/appBar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: (() => add(null)),
                child: new Text("Ajouter",
                    style:
                        new TextStyle(color: Colors.white, fontFamily: 'Jost')),
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
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                    ),
                    carousel.VerticalDivider(),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Ma Liste',
                              style:
                                  TextStyle(fontSize: 20.0, fontFamily: 'Jost'),
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
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
              carousel.Carousel(),
            ],
          ),
        ));
  }

  Future<Null> add(Game game) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
              title: new Text('Ajouter un jeu'),
              content: new TextField(
                decoration: new InputDecoration(
                    labelText: "Nom du jeu : ",
                    hintText:
                        (game == null) ? "Ex: Fifa21, Dofus, ..." : game.name),
                onChanged: (String str) {
                  newList = str;
                },
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: (() => Navigator.pop(buildContext)),
                    child: new Text('Annuler')),
                new FlatButton(
                  onPressed: () {
                    // Ajouter à la base de données
                    if (newList != null) {
                      if (game == null) {
                        game = new Game();
                        Map<String, dynamic> map = {
                          'name': newList,
                        };
                        game.fromMap(map);
                      } else {
                        game.name = newList;
                      }
                      DatabaseClient().upsertGame(game);
                      newList = null;
                    }
                    Navigator.pop(buildContext);
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

  // void getGames() {
  //   DatabaseClient().showGames().then((games) {
  //     setState(() {
  //       this.games = games;
  //     });
  //   });
  // }
}
