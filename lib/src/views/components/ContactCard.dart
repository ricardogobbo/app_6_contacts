import 'dart:io';

import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/models/ContactDAO.dart';
import 'package:app_6_contacts/src/views/ContactEditView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {

  final Contact contact;
  final Function onUpdate;

  final dao = ContactDAO();

  ContactCard(this.contact, this.onUpdate);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => _showOptions(context),//,
      child: Card(
        child: Padding(padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: contact.image != null ?
                            FileImage(File(contact.image)) :
                            AssetImage('assets/person.jpg')
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contact.name,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(contact.phone ?? "",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.normal)),
                    Text(contact.email ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal)),

                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }

  _showOptions(context){
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
                          launch("tel:${contact.phone}");
                        },
                        child: Text("Ligar", style: TextStyle(fontSize:24, color: Colors.blue),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          showContactEditView(context, contact);
                        },
                        child: Text("Editar", style: TextStyle(fontSize:24, color: Colors.blue),),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: FlatButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await dao.delete(contact.id);
                          onUpdate();
                        },
                        child: Text("Excluir", style: TextStyle(fontSize:24, color: Colors.red),),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}


dynamic showContactEditView(BuildContext context, Contact contact) async{
  return await Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => ContactEditView(contact: contact))
  );
}