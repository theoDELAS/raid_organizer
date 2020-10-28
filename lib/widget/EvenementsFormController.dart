import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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

  // EvenementsFormController(Game game) {
  //   this.game = game;
  // }

  @override
  _EvenementsFormControllerState createState() =>
      _EvenementsFormControllerState();
}

class _EvenementsFormControllerState extends State<EvenementsFormController> {
  // get game => this.game;

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
  num slots;
  DateTime date;
  TimeOfDay hour;
  bool is_private = false;

  @override
  Widget build(BuildContext context) {
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
                      FlatButton(
                        color: Colors.black54,
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              theme: DatePickerTheme(
                                  headerColor: Colors.green,
                                  backgroundColor: Colors.grey[800]),
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2020, 12, 31),
                              onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.fr);
                        },
                        child: Text(
                          (date == null)
                              ? "Date et heure de l'évènement".toUpperCase()
                              : date.toString(),
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
                            validator: (val) {
                              final supportValue = int.tryParse(val);
                              return supportValue >= 2 && supportValue <= 5
                                  ? "Le nombre de participants doit être entre 2 et 5"
                                  : val;
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
                            // Provider.of(context, listen: false);
                            // Ajouter à la base de données
                            if (title != null) {
                              Map<String, Object> map = {'title': title};
                              // if (image != null) {
                              //   map['image'] = image;
                              // }
                              if (date != null) {
                                map['date'] = date;
                              }
                              if (description != null) {
                                map['description'] = description;
                              }
                              if (slots != null) {
                                map['slots'] = slots;
                              }
                              Evenement evenement = new Evenement();
                              print(evenement.title);
                              evenement.fromMap(map);
                              print(evenement.description);
                              DatabaseClient()
                                  .addEvent(evenement)
                                  .then((value) {
                                // game.id = null;
                                print(evenement.slots);

                                title = null;
                                image = null;
                                description = null;
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext buildContext) {
                                  return HomeController();
                                }));
                              });
                              print(evenement.title);
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

  // Future<Null> showDate() async {
  //   DateTime choice = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1999),
  //       lastDate: DateTime(2021));
  //   if (choice != null) {
  //     setState(() {
  //       date = choice;
  //     });
  //   }
  // }

  // Future<Null> showHour() async {
  //   TimeOfDay choice =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //   if (choice != null) {
  //     setState(() {
  //       hour = choice;
  //     });
  //   }
  // }

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
            // slots = string;
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
}

enum TypeTextField { title, date, hour, description, slots, is_private }
