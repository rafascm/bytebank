import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accNumController = TextEditingController();

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Contact')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            NameInput(nameController: _nameController),
            AccountInput(accNumController: _accNumController),
            CreateButton(
              nameController: _nameController,
              accNumController: _accNumController,
              dao: _dao,
            )
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key key,
    @required TextEditingController nameController,
    @required TextEditingController accNumController,
    @required ContactDao dao,
  })  : _nameController = nameController,
        _accNumController = accNumController,
        _dao = dao,
        super(key: key);

  final TextEditingController _nameController;
  final TextEditingController _accNumController;
  final ContactDao _dao;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: double.maxFinite,
        child: RaisedButton(
          child: Text('Create'),
          onPressed: () async {
            final String name = _nameController.text;
            final int accNumber = int.tryParse(_accNumController.text);
            final Contact newContact = Contact(0, name, accNumber);

            await _dao.save(newContact);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class AccountInput extends StatelessWidget {
  const AccountInput({
    Key key,
    @required TextEditingController accNumController,
  })  : _accNumController = accNumController,
        super(key: key);

  final TextEditingController _accNumController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: _accNumController,
        decoration: InputDecoration(
          labelText: 'Account Number',
        ),
        style: TextStyle(fontSize: 24.0),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({
    Key key,
    @required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Full name',
      ),
      style: TextStyle(fontSize: 24.0),
    );
  }
}
