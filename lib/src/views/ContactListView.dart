import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/models/ContactDAO.dart';
import 'package:flutter/material.dart';

class ContactListView extends StatefulWidget {
  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Contacts"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: (){}
              )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_call),
        onPressed: (){
          var contact = Contact.fromMap({
              "name": "Ricardo",
              "email": "rg.aguas@gmail.com"
          });

          print(contact);
        },
      ),
    );
  }

}
