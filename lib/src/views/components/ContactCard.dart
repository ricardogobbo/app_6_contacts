import 'dart:io';

import 'package:app_6_contacts/src/models/Contact.dart';
import 'package:app_6_contacts/src/views/ContactEditView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {

  final Contact contact;

  ContactCard(this.contact);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => showContactEditView(context, contact),
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
}


showContactEditView(BuildContext context, Contact contact) {
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => ContactEditView(contact: contact))
  );
}