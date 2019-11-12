import 'dart:io';

import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/models/ContactDAO.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final dao = ContactDAO();

  @override
  void initState() {
    super.initState();
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
    return WillPopScope(
      onWillPop: _userWillPop,
      child: Scaffold(

        appBar: AppBar(
          title: Text(_editingContact.id == null ? "New Contact" : "Edit ${_editingContact.name ?? "Contact"}"),
          centerTitle: true,
        ),


        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _editingContact.image != null ?
                              FileImage(File(_editingContact.image)) :
                              AssetImage('assets/person.jpg')
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  _showImageSourceOptions(context);
                },
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
          onPressed: () async{
            _saveContact();
          },
        ),

      ),
    );
  }

  Future<bool> _userWillPop() {
    if(_userEdited){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Atenção!"),
            content: new Text("As informações serão perdidas. Deseja sair?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("SAIR", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("FICAR", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _saveContact() async {
    if(_editingContact.name != null && _editingContact.name.isNotEmpty){
      Contact contact = await dao.save(_editingContact);
      Navigator.pop(context, contact);
    }else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Erro ao Salvar"),
            content: new Text("Você precisa informar pelo menos o nome do contato"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  }

  _showImageSourceOptions(context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          _pickImageFrom(ImageSource.gallery);
                        },
                        child: Text("Imagem da Galeria", style: TextStyle(fontSize:24, color: Colors.blue),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          _pickImageFrom(ImageSource.camera);
                        },
                        child: Text("Tirar Foto", style: TextStyle(fontSize:24, color: Colors.blue),),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  _pickImageFrom(from){
    ImagePicker.pickImage(source: from).then((file){
      if(file == null) return;
      setState(() {
        _userEdited = true;
        _editingContact.image = file.path;
      });
    });
  }


}
