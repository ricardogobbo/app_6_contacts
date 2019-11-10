import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/models/ContactDAO.dart';
import 'package:app_6_contacts/src/views/components/ContactCard.dart';
import 'package:flutter/material.dart';

class ContactListView extends StatefulWidget {
  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {

  final ContactDAO dao = ContactDAO();

  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();
    dao.list().then((list){
      setState(() {
        contacts = list;
      });
    });
  }

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
            onPressed: (){})
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showContactEditView(context, null),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index){
            return ContactCard(contacts[index]);
          }
      ),
    );
  }

}
