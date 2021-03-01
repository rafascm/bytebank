import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';
import 'contact_item.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return _showLoading();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return _showList(snapshot);
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm()),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Center _showLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Loading'),
        ],
      ),
    );
  }

  ListView _showList(AsyncSnapshot<List<Contact>> snapshot) {
    final List<Contact> contacts = snapshot.data;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ContactItem(contacts[index]);
      },
      itemCount: contacts.length,
    );
  }
}
