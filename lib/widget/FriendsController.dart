import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raid_organizer/model/friends.dart';


class FriendsList extends StatefulWidget {


  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Friends> friends = [
    Friends(nom: 'Naroda', imageProfil: 'test4.jpg', jeu: 'wow.jpg', descritpion: "Venez jouer avec moi, partie trop délirante lol", slot: '3/4') ,
    Friends(nom: 'Sheguey', imageProfil: 'image-2.jpg', jeu: 'dofus.png', descritpion: "Venez jouer avec moi, partie trop délirante lol", slot: '3/6'),    
    Friends(nom: 'username', imageProfil: 'image-1.jpg', jeu:'fifa.jpg', descritpion: "Venez jouer avec moi, partie trop délirante lol", slot: '2/4'),
    Friends(nom: 'username', imageProfil: 'image-2.jpg', jeu: 'wow.jpg', descritpion: "Venez jouer avec moi, partie trop délirante lol", slot: '1/3'),
    Friends(nom: 'username', imageProfil: 'image-1.jpg', jeu: 'dofus.png', descritpion: "Venez jouer avec moi, partie trop délirante lol", slot: '2/5'),
  ];

  /*Fenêtre modale*/
  Widget _dialogBuilder(BuildContext context, Friends friends) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      backgroundColor: Colors.blueGrey.shade700,
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        /*afficher le jeu à la place de l'image Profil*/
        Image.asset('images/${friends.jeu}'),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                friends.nom.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Jost',
                  color: Color.fromRGBO(2, 196, 131, 1)),
              ),
              SizedBox(height: 20.0),
              Text(
                'Description du jeu : ',
                style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
              ),
              SizedBox(height: 20.0),
              Text(
                friends.descritpion,
                style: localTheme.textTheme.bodyText1,
              ),
              SizedBox(height: 20.0),
              Row(
                
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text("  "),
                  Text(
                    friends.slot,
                    style: TextStyle(
                      color: Color.fromRGBO(2, 196, 131, 1),
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
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
        ],
      ),

      /*Liste des Amis*/
      body: ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
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
                          fontFamily: 'Jost', fontSize: 17.0, fontWeight: FontWeight.bold)),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('images/${friends[index].imageProfil}'),
                  ),
                  trailing: FlatButton(
                    color: Color.fromRGBO(2, 196, 131, 1),
                    child: Text('Ajouter en ami',
                    style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                
                
                ),
              ),
            );
          }),
    );
  }
}
