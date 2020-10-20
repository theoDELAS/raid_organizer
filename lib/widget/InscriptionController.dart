import 'package:flutter/material.dart';
import 'package:raid_organizer/widget/ConnexionController.dart';
import 'package:raid_organizer/widget/HomeController.dart';

class InscriptionController extends StatelessWidget {
  String email = '';
  String password = '';
  String confPassword = '';

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text('Inscription'),
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
                      labelText: 'E-mail', border: OutlineInputBorder()),
                  validator: (val) =>
                      val.isEmpty ? 'Saisissez votre email' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Mot de passe', border: OutlineInputBorder()),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val.length < 6
                      ? 'Votre mot de passe est trop court (6 caractères min)'
                      : null,
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirmez le mot de passe',
                      border: OutlineInputBorder()),
                  onChanged: (val) => confPassword = val,
                  validator: (val) => confPassword != password
                      ? 'Confirmez votre mot de passe'
                      : null,
                  obscureText: true,
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromRGBO(2, 196, 131, 1),
                  onPressed: () {
                    if (_keyForm.currentState.validate()) {
                      /*Changer la route vers la HomeController (err)*/
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext buildContext) {
                        return HomeController();
                      }));
                    }
                  },
                  child: Text("S'INSCRIRE",
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Déjà un compte?',
                   style: TextStyle(color: Colors.white, fontSize: 15.0)
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromRGBO(2, 196, 131, 1),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext buildContext) {
                      return ConnexionController();
                    }));
                  },
                  child: Text(
                      'Connexion'.toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 15.0)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
