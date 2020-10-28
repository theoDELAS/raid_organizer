import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:developer';

import 'package:raid_organizer/widget/EvenementsController.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Game> games;

  @override
  void initState() {
    super.initState();
    getGames();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 5,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: games.map((game) {
          print(game.name);
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        game.image,
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext buildContext) {
                      return EvenementsController(game);
                    }));
                  });
            },
          );
        }).toList(),
      ),
    );
  }

  void getGames() {
    DatabaseClient().showGames().then((games) {
      setState(() {
        this.games = games;
      });
    });
  }
}

class VerticalDivider extends StatelessWidget {
  VerticalDivider(this.param);

  final double param;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: this.param,
      width: 1.0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
