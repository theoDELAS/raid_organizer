import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/services.dart';
import 'package:raid_organizer/model/event.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:raid_organizer/widget/EvenementsFormController.dart';
import 'package:raid_organizer/widget/GameDetailsController.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:raid_organizer/widget/HomeController.dart';

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
  get game => this.game;

  @override
  void initState() {
    super.initState();
    // is_private = false;
    getEvents();
  }

  String newList;
  List<Game> games;
  List<Evenement> evenements;

  void getEvents() {
    DatabaseClient().showEvents().then((evenements) {
      setState(() {
        this.evenements = evenements;
      });
    });
  }

  String title;
  String image;
  String description;
  String slots;
  String game_id;
  DateTime date;
  // bool is_private = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            FlatButton(
              onPressed: (() => Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return new EvenementsFormController(widget.game);
                  }))),
              child: Text(
                "Créer un évènement".toUpperCase(),
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
            for (var event in evenements)
              if (widget.game.id.toString() == event.game_id)
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.13,
                    margin: const EdgeInsets.only(bottom: 20),
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
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: 5,
                          height: 110,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Jost',
                                      fontSize: 16,
                                    ),
                                  )),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  Text(
                                    "0/" + event.slots,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Jost',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.only(left: 150, top: 75),
                                  child: Text(
                                    "Début : 20h15",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Jost',
                                      fontSize: 15,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ],
                        ),
                        child: IconSlideAction(
                            caption: 'Rejoindre',
                            color: Color.fromRGBO(1, 191, 136, 1),
                            icon: Icons.control_point_duplicate_rounded,
                            foregroundColor: Colors.white,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext buildContext) {
                                return HomeController();
                              }));
                            }))
                  ],
                ),
            SizedBox(height: 40),
            Text(
              "Activités en cours".toUpperCase(),
              style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
            ),
          ],
        ))));
  }
}
