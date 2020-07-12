import 'package:bytebank_2/components/editor.dart';
import 'package:bytebank_2/dao/contact_dao.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final String _contactFormTitle = 'New contact';
  final TextEditingController _controllerFullName = TextEditingController();
  final String _labelFieldFullName = 'Full name';
  final String _hintFieldFullName = 'Your name here';
  final TextEditingController _controllerAccountNumber =
      TextEditingController();
  final String _labelFieldAccountNumber = 'Account Number';
  final String _hintFieldAccountNumber = 'Your account here';
  final TextInputType _inputTypeFieldAccountNumber = TextInputType.number;
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contactFormTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Editor(
              _controllerFullName,
              label: _labelFieldFullName,
              hint: _hintFieldFullName,
            ),
            Editor(
              _controllerAccountNumber,
              label: _labelFieldAccountNumber,
              hint: _hintFieldAccountNumber,
              inputType: _inputTypeFieldAccountNumber,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50.00,
                child: RaisedButton(
                  child: Text(
                    'Create',
                    style: TextStyle(fontSize: 16.00),
                  ),
                  onPressed: () {
                    final String name = _controllerFullName.text;
                    final int accountNumber =
                        int.tryParse(_controllerAccountNumber.text);
                    final Contact newContact = Contact(name, accountNumber);
                    _dao
                        .save(newContact)
                        .then((id) => Navigator.pop(context, newContact));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
