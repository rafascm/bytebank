import 'package:bytebank/database/app_db.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';
import 'contact_item.dart';

class ContactsList extends StatelessWidget {
  //final List<Contact> contacts = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: findAll(),
        builder: (context, snapshot) {
          final List<Contact> contacts = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ContactItem(contacts[index]);
            },
            itemCount: contacts.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => ContactForm()),
              )
              .then((newContact) => debugPrint(newContact.toString()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
