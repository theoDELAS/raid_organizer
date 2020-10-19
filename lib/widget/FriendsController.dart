import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/friends.dart';

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

  /*Fenêtre modale*/
  Widget _dialogBuilder(BuildContext context, Friends friends) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      backgroundColor: Colors.blueGrey.shade700,
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        /*afficher le jeu à la place de l'image Profil*/
        Image.asset('images/${friends.imageProfil}'),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                friends.nom.toUpperCase(),
                style: TextStyle(fontFamily: 'Jost'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Description du jeu',
                style: localTheme.textTheme.bodyText1,
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: Wrap(children: <Widget>[
                  FlatButton(
                    /*Afficher les détails du jeu en cours: nb de joueurs... */
                    onPressed: () {},
                    child: Text(
                      'REJOINDRE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Color.fromRGBO(2, 196, 131, 1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ANNULER'),
                  )
                ]),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,

      /*Navbar*/
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(
          'Mes Amis'.toUpperCase(),
          style: TextStyle(fontFamily: 'Jost'),
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

      /*Liste des Amis*/
      body: ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Card(
                elevation: 0,
                color: Colors.blueGrey.shade700,
                child: ListTile(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) =>
                          _dialogBuilder(context, friends[index])),
                  title: Text(friends[index].nom,
                      style: TextStyle(
                          fontFamily: 'Jost', fontWeight: FontWeight.bold)),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('images/${friends[index].imageProfil}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
