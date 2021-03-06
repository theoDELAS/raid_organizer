import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:raid_organizer/model/event.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:raid_organizer/widget/EvenementsController.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:raid_organizer/widget/HomeController.dart';

import 'appBar.dart';

class EvenementsFormController extends StatefulWidget {
  Evenement evenement;
  Game game;

  EvenementsFormController(Game game) {
    this.game = game;
  }

  @override
  _EvenementsFormControllerState createState() =>
      _EvenementsFormControllerState();
}

class _EvenementsFormControllerState extends State<EvenementsFormController> {
  get game => game;

  @override
  void initState() {
    super.initState();
    // is_private = false;
    date = null;
  }

  String newList;
  List<Game> games;

  String title;
  String image;
  String description;
  String slots;
  String game_id;
  DateTime date;
  bool is_private = false;

  @override
  Widget build(BuildContext context) {
    print("1: $date");
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        appBar: appbar(context),
        body: SingleChildScrollView(
          child: Center(
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
                      myTextField(TypeTextField.title, "Titre de l'évènement"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Évènement privé",
                            style: TextStyle(
                                fontFamily: 'Jost',
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Switch(
                            activeColor: Color.fromRGBO(2, 196, 131, 1),
                            inactiveThumbColor: Colors.red[700],
                            value: false,
                            onChanged: (bool value) {
                              value = false;
                              setState(() {
                                is_private = value;
                                print(is_private);
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        color: Colors.black54,
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              // theme: DatePickerTheme(
                              //     headerColor: Colors.green,
                              //     backgroundColor: Colors.grey[800]),
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2020, 12, 31),
                              onChanged: (DateTime mydate) {
                            print('change $date');
                            date = mydate;
                          }, onConfirm: (DateTime mydate) {
                            print('confirm $date');
                            setState(() {
                              date = mydate;
                              print(date);
                            });

                            print("definitive $date");
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.fr);
                          inspect("after def: $date");
                        },
                        child: Text(
                          (date == null)
                              ? "Date et heure de l'évènement".toUpperCase()
                              : DateFormat("dd-MM-yyy HH:mm:ss").format(date),
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Jost'),
                        ),
                      ),
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      myTextField(TypeTextField.description,
                          "Description de l'évènement"),
                      SizedBox(height: 20),
                      Text(
                        "Nombre de participants".toUpperCase(),
                        style:
                            TextStyle(fontFamily: 'Jost', color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 120,
                        child: TextFormField(
                            // validator: (val) {
                            //   final supportValue = int.parse(val);
                            //   return supportValue >= 2 && supportValue <= 5
                            //       ? "Le nombre de participants doit être entre 2 et 5"
                            //       : val.toString();
                            // },
                            onChanged: (val) {
                              slots = val;
                            },
                            decoration: InputDecoration(
                                labelText: "(Entre 2 et 5)",
                                labelStyle: TextStyle(
                                  fontFamily: 'Jost',
                                  color: Color.fromRGBO(2, 196, 131, 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(2, 196, 131, 1))),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ]),
                      ),
                      SizedBox(height: 30),
                      FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Color.fromRGBO(1, 196, 131, 1),
                          padding: EdgeInsets.all(7),
                          onPressed: () {
                            print("onpress : $date");
                            // Ajouter à la base de données
                            if (title != null) {
                              Map<String, Object> map = {'title': title};
                              if (widget.game.id != null) {
                                map['game_id'] = widget.game.id.toString();
                              }
                              // if (is_private != null) {
                              //   map['is_private'] = is_private;
                              // }
                              if (date != null) {
                                print("before: $date");
                                map['date'] = date.toIso8601String();
                                print(date.runtimeType);
                                print("last: $date");
                              }
                              if (description != null) {
                                map['description'] = description;
                              }
                              if (slots != null) {
                                map['slots'] = slots;
                              }
                              Evenement evenement = new Evenement();
                              evenement.fromMap(map);
                              print(evenement.date);
                              DatabaseClient()
                                  .addEvent(evenement)
                                  .then((value) {
                                title = null;
                                image = null;
                                description = null;
                                date = null;
                                slots = null;
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext buildContext) {
                                  return EvenementsController(widget.game);
                                }));
                              });
                            }
                          },
                          child: Text(
                            "Créer l'évènement !".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Jost',
                                fontSize: 20),
                          )),
                    ],
                  ))
            ],
          )),
        ));
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
            date = date;
            break;
          case TypeTextField.description:
            description = string;
            break;
          case TypeTextField.slots:
            slots = slots;
            break;
          case TypeTextField.is_private:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }
}

enum TypeTextField { title, date, description, slots, is_private }
