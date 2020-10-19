import 'package:flutter/material.dart';
import 'package:raid_organizer/widget/FriendsModel.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {

  List<Friends> friends = [
    Friends(nom: 'Amis1', imageProfil: 'image-1.jpg'),
    Friends(nom: 'Amis2', imageProfil: 'image-2.jpg'),
    Friends(nom: 'Amis1', imageProfil: 'image-1.jpg'),
    Friends(nom: 'Amis2', imageProfil: 'image-2.jpg'),
    Friends(nom: 'Amis1', imageProfil: 'image-1.jpg'),
    Friends(nom: 'Amis2', imageProfil: 'image-2.jpg'),
    Friends(nom: 'Amis1', imageProfil: 'image-1.jpg'),
    Friends(nom: 'Amis2', imageProfil: 'image-2.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(
          'Mes Amis'
        ),
        actions: <Widget>[
          Icon(
            Icons.search,
          ),
          Icon(
            Icons.more_vert,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: friends.length,
          itemBuilder: (context, index){

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){

                },
                title: Text(friends[index].nom,
                  style: Theme.of(context).textTheme.title),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/${friends[index].imageProfil}'),
                ),
              ),
            ),
          );
          }),
    );
  }
}
