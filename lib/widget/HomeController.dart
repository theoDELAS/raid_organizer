import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'dart:async';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/EmptyData.dart';

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
                    trailing: new IconButton(
                        icon: new Icon(Icons.delete),
                        onPressed: () {
                          DatabaseClient()
                              .deleteGame(game.id, 'game')
                              .then((int) {
                            print("L'int a été récupéré : $int");
                            getGames();
                          });
                        }),
                    leading: new IconButton(
                        icon: new Icon(Icons.edit),
                        onPressed: (() => add(game))),
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
                    labelText: "Liste: ",
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
                        Map<String, dynamic> map = {'name': newList};
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
