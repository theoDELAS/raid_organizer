import 'package:flutter/material.dart';
import 'package:raid_organizer/model/user.dart';
import 'package:raid_organizer/model/game.dart';
import 'package:raid_organizer/widget/HomeController.dart';
import 'package:raid_organizer/model/database.dart';

class ConnexionController extends StatefulWidget {
  @override
  _ConnexionControllerState createState() => _ConnexionControllerState();
}

class _ConnexionControllerState extends State<ConnexionController> {
  String username = '';
  String password = '';

  List<User> users;

  void getUsers() {
    DatabaseClient().showUsers().then((users) {
      setState(() {
        this.users = users;
      });
    });
  } 

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text('Connexion'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Nom d'utilisateur",
                      border: OutlineInputBorder()),
                  validator: (val) =>
                  val.isEmpty ? 'Veuillez saisir votre e-mail' : null,
                  onChanged: (val) => username = val,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Mot de passe', border: OutlineInputBorder()),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val.length < 6
                      ? 'Veuillez saisir votre mot de passe'
                      : null,
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromRGBO(2, 196, 131, 1),
                  onPressed: () {
                    print(users);
                    // if (_keyForm.currentState.validate()) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (BuildContext buildContext) {
                    //       return HomeController();
                    //     }),
                    //   );
                    // }
                  },
                  child: Text("Connexion".toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

