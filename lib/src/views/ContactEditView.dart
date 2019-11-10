import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:flutter/material.dart';

class ContactEditView extends StatefulWidget {

  final Contact contact;

  ContactEditView({this.contact});

  @override
  _ContactEditViewState createState() => _ContactEditViewState();
}

class _ContactEditViewState extends State<ContactEditView> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool _userEdited = false;
  Contact _editingContact;


  @override
  void initState() {
    setState(() {
      if(widget.contact == null){
        _editingContact = Contact.fromMap({});
      }else{
        _editingContact = widget.contact;
        _nameController.text = _editingContact.name;
        _phoneController.text = _editingContact.phone;
        _emailController.text = _editingContact.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text(_editingContact.id == null ? "New Contact" : "Edit ${_editingContact.name ?? "Contact"}"),
        centerTitle: true,
      ),


      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/person.jpg')
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Contact Name",
              ),
              onChanged: (text){
                _userEdited = true;
                setState(() {
                  _editingContact.name = text;
                });
              },
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
              ),
              onChanged: (text){
                _userEdited = true;
                _editingContact.phone = text;
              },
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail Address",
              ),
              onChanged: (text){
                _userEdited = true;
                _editingContact.email = text;
              },
            ),
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){},
      ),

    );
  }
}
