import 'package:flutter/material.dart';

class Inscription extends StatelessWidget {

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
        title: Text(
          'Inscription'
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
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromRGBO(2, 196, 131, 1),
                  onPressed: (){
                    if(_keyForm.currentState.validate()){
                      print('$email et $password');
                    }
                  },
                  child: Text(
                    'Inscription',
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
