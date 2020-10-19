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
          decoration: BoxDecoration(
            color: Colors.blueGrey[700],
            borderRadius: BorderRadius.all(
              Radius.circular(0),
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
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image(
                        image: AssetImage("images/test1.jpg"),
                      ),
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
            ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Voir',
          color: Colors.blue,
          icon: Icons.remove_red_eye,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext buildContext) {
                    return HomeController();
                  }));
            }
        ),
      ],
    );
  }
}
