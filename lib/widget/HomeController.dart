import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'dart:async';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/EmptyData.dart';
import 'package:raid_organizer/widget/GameDetails.dart';

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

  @override
  void initState() {
    super.initState();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new FlatButton(
              onPressed: (() => add(null)),
              child: new Text("Ajouter",
                  style: new TextStyle(color: Colors.white)),
            )
          ],
        ),
        body: (games == null || games.length == 0)
            ? new EmptyData()
            : new ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, g) {
                  Game game = games[g];
                  return new ListTile(
                    title: new Text(game.name),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext buildContext) {
                                return new GameDetail(game);
                              },
                              fullscreenDialog: false));
                    },
                  );
                }));
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
                      DatabaseClient().upsertGame(game).then((g) => getGames());
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

  void getGames() {
    DatabaseClient().showGames().then((games) {
      setState(() {
        this.games = games;
      });
    });
  }
}
