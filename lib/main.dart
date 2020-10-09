import 'package:flutter/material.dart';
import 'package:raid_organizer/widget/HomeController.dart';
import 'widget/HomeController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeController(title: 'Raid Organizer'),
    );
  }
}
