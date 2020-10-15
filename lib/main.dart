import 'package:flutter/material.dart';
import 'package:raid_organizer/widget/HomeController.dart';
import 'widget/HomeController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raid Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeController(title: 'Raid Organizer'),
    );
  }
}
