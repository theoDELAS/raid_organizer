import 'package:flutter/material.dart';

class Formulaire extends StatelessWidget {

  String email = '';
  String password = '';
  String confPassword = '';

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insciption'
        ),
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
                    labelText: 'Email',
                    border: OutlineInputBorder()
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez email': null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder()
                    ),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val.length < 6 ? 'Trop court' : null,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirmez le mot de passe',
                      border: OutlineInputBorder()
                    ),
                  onChanged: (val) => confPassword = val,
                  validator: (val) => confPassword != password ? 'Confirmez votre mdp' : null,
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: (){
                    if(_keyForm.currentState.validate()){
                      print('$email et $password');
                    }
                  },
                  borderSide: BorderSide(width: 1.0, color: Colors.green),
                  child: Text(
                    'Validez-moi pour voir les listes',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.blue,
                  onPressed: (){
                    if(_keyForm.currentState.validate()){
                      print('$email et $password');
                    }
                  },
                  child: Text(
                    'Besoin de voir les listes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
