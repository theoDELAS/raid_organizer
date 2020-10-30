import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:raid_organizer/widget/HomeController.dart';

class EventFriendCard extends StatefulWidget {
  @override
  _EventFriendCardState createState() => _EventFriendCardState();
}

class _EventFriendCardState extends State<EventFriendCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
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
            image: AssetImage("images/test2.jpg"),
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                caption: 'Voir',
                color: Color.fromRGBO(1, 191, 136, 1),
                icon: Icons.remove_red_eye,
                foregroundColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return HomeController();
                  }));
                }))
      ],
    );
  }
}
