import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:raid_organizer/widget/HomeController.dart';

class GameDetail extends StatefulWidget {
  Game game;

  GameDetail(Game game) {
    this.game = game;
  }

  @override
  _GameDetailState createState() => new _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  String newList;
  List<Game> games;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(widget.game.name),
        ),
        body: Row(
          children: <Widget>[
            FlatButton(
                color: Colors.blue[800],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(15.0),
                splashColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.blue)),
                onPressed: (() => update(widget.game)),
                child: Text(
                  "MODIFIER",
                  style: TextStyle(fontSize: 20),
                )),
            FlatButton(
              color: Colors.red[800],
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(15.0),
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(color: Colors.red)),
              onPressed: (() {
                DatabaseClient().deleteGame(widget.game.id, 'game');
              }),
              child: Text(
                "SUPPRIMER",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ));
  }

  Future<Null> update(Game game) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
              title: new Text('Modifier le jeu'),
              content: new TextField(
                decoration: new InputDecoration(
                    labelText: "Nouveau nom : ",
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
