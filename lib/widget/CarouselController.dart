import 'package:flutter/material.dart';
import 'package:raid_organizer/model/database.dart';
import 'dart:async';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/CarouselController.dart';
import 'package:raid_organizer/widget/EmptyData.dart';
import 'package:raid_organizer/widget/GameDetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:developer';
import 'package:raid_organizer/widget/CarouselController.dart' as prefix;

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Game> games;

  @override
  Widget build(BuildContext context) {
    inspect(games);
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
        items: games.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  // child: Text(i.name));
                  child: Image.network(
                      'https://picsum.photos/id/${i.id}/200/120/'));
            },
          );
        }).toList(),
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }
}
