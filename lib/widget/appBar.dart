import 'package:flutter/material.dart';

Widget appbar(BuildContext buildContext) {
  String title = 'RAID ORGANIZER';
  return AppBar(
    backgroundColor: Colors.blueGrey.shade700,
    elevation: 0,
    leading: CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('images/test4.jpg'),
    ),
    title: Center(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
            color: Colors.black),
      ),
    ),
    actions: <Widget>[
      IconButton(
        iconSize: 40,
        icon: Icon(
          Icons.group,
          color: Color.fromRGBO(2, 196, 131, 1),
        ),
        onPressed: () {
          // do something
        },
      ),
    ],
  );
}
