import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/event.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:raid_organizer/widget/GameDetailsController.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'appBar.dart';

class EvenementsController extends StatefulWidget {
  Evenement evenement;
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
    is_private = false;
  }

  String newList;
  List<Game> games;

  String title;
  String image;
  String description;
  String slots;
  DateTime date;
  TimeOfDay hour;
  bool is_private = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: Center(
            child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            FlatButton(
              onPressed: (() => add(null)),
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
                style: TextStyle(fontSize: 20, fontFamily: 'Jost')),
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
              style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
            ),
          ],
        )));
  }

  Future<Null> add(Evenement evenement) async {
    await showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade700,
            appBar: appbar(context),
            body: Center(
                child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Création de votre évènement".toUpperCase(),
                  style: TextStyle(
                      fontSize: 25, fontFamily: 'Jost', color: Colors.white),
                ),
                SizedBox(height: 25),
                Card(
                    color: Colors.blueGrey.shade700,
                    elevation: 0,
                    child: Column(
                      children: [
                        myTextField(
                            TypeTextField.title, "Titre de l'évènement"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Évènement privé",
                              style: TextStyle(
                                  fontFamily: 'Jost',
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Switch(
                              activeColor: Color.fromRGBO(2, 196, 131, 1),
                              inactiveThumbColor: Colors.red[700],
                              value: is_private,
                              onChanged: (bool value) {
                                setState(() {
                                  is_private = value;
                                  print(is_private);
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Date et heure de l'évènement".toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Jost',
                              color: Colors.white),
                        ),
                        Column(
                          children: [
                            FlatButton(
                              color: Colors.blueGrey.shade600,
                              child: Text((date == null)
                                  ? "Sélectionnez une date"
                                  : DateFormat("dd-MM-yyyy")
                                      .format(date)
                                      .toString()),
                              onPressed: showDate,
                            ),
                            FlatButton(
                              color: Colors.blueGrey.shade600,
                              child: Text((hour == null)
                                  ? "Sélectionnez une heure"
                                  : hour.toString()),
                              onPressed: showHour,
                            )
                          ],
                        )
                      ],
                    ))
              ],
            )),
            // title: Text('Ajouter un jeu'),
            // content: Card(
            //     child: Column(children: <Widget>[
            //   myTextField(TypeTextField.title, "Nom du jeu"),
            //   myTextField(TypeTextField.description, "Image du jeu"),
            //   myTextField(TypeTextField.slots, "Description du jeu"),
            //   myTextField(TypeTextField.is_private, "Description du jeu"),
            //   myTextField(TypeTextField.date, "Description du jeu"),
            // ])),
            // actions: <Widget>[
            //   FlatButton(
            //       onPressed: (() => Navigator.pop(buildContext)),
            //       child: Text('Annuler')),
            //   FlatButton(
            //     onPressed: () {
            //       // Ajouter à la base de données
            //       if (title != null) {
            //         Map<String, dynamic> map = {'name': title};
            //         if (image != null) {
            //           map['image'] = image;
            //         }
            //         if (description != null) {
            //           map['description'] = description;
            //         }
            //         Evenement evenement = new Evenement();
            //         evenement.fromMap(map);
            //         DatabaseClient().upsertEvenement(evenement).then((value) {
            //           title = null;
            //           image = null;
            //           description = null;
            //           Navigator.pop(context);
            //         });
            //       }
            //     },
            //     child: Text(
            //       'Valider',
            //       style: TextStyle(
            //         color: Colors.green,
            //       ),
            //     ),
            //   )
            // ]
          );
        });
  }

  Future<Null> showDate() async {
    DateTime choice = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1999),
        lastDate: DateTime(2021));
    if (choice != null) {
      setState(() {
        date = choice;
      });
    }
  }

  Future<Null> showHour() async {
    TimeOfDay choice =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (choice != null) {
      setState(() {
        hour = choice;
      });
    }
  }

  TextField myTextField(TypeTextField type, String label) {
    return TextField(
      decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'Jost', color: Color.fromRGBO(2, 196, 131, 1)),
          fillColor: Colors.blueGrey.shade700,
          filled: true,
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(2, 196, 131, 1))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.title:
            title = string;
            break;
          case TypeTextField.date:
            //
            break;
          case TypeTextField.description:
            description = string;
            break;
          case TypeTextField.slots:
            slots = string;
            break;
          case TypeTextField.is_private:
            // TODO: Handle this case.
            break;
          case TypeTextField.hour:
            //
            break;
        }
      },
    );
  }

  // void getGames() {
  //   DatabaseClient().showGames().then((games) {
  //     setState(() {
  //       this.games = games;
  //     });
  //   });
  // }
}

enum TypeTextField { title, date, hour, description, slots, is_private }
