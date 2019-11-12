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
  bool _orderAsc = true;
  List<Contact> contacts = List();


  @override
  void initState() {
    super.initState();
    _initContacts();
  }

  void _initContacts(){
    dao.list(sort: Contact.NAME_COLUMN, order: _orderAsc ? 'ASC' : 'DESC').then((list){
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
          PopupMenuButton(
            icon: Icon(Icons.more_vert),

            onSelected: (value){
              if(value == true){
                _orderAsc = true;
              }else{
                _orderAsc = false;
              }
              _initContacts();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Ordenar A - Z"),
                value: true,
              ),
              PopupMenuItem(
                child: Text("Ordenar Z - A"),
                value: false,
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{
            final contact = await showContactEditView(context, null);
            if(contact != null)
              _initContacts();
          },
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index){
            return ContactCard(contacts[index], _initContacts);
          }
      ),
    );
  }

}
