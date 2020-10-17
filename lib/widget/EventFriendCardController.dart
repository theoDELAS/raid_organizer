import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:raid_organizer/widget/CarouselController.dart' as carousel;

class EventFriendCard extends StatefulWidget {
  @override
  _EventFriendCardState createState() => _EventFriendCardState();
}

class _EventFriendCardState extends State<EventFriendCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 22),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      color: Colors.white, width: 1, style: BorderStyle.solid),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jost',
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      Text(
                        "0/6",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image(
                  width: 100,
                  image: AssetImage("images/test1.jpg"),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    "Début : 20h15",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Jost',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
