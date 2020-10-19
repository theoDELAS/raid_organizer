import 'package:flutter/material.dart';
import 'package:raid_organizer/contact_model.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  List<Contact> contacts = [
    Contact(nom: 'Amis1', imageProfil: 'image-1.jpg'),
    Contact(nom: 'Amis2', imageProfil: 'image-2.jpg'),
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
        itemCount: contacts.length,
          itemBuilder: (context, index){

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            child: Card(
              child: ListTile(
                onTap: (){

                },
                title: Text(contacts[index].nom,
                  style: Theme.of(context).textTheme.title),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/${contacts[index].imageProfil}'),
                ),
              ),
            ),
          );
          }),
    );
  }
}
