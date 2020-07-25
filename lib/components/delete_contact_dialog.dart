import 'package:bytebank_2/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'package:bytebank_2/models/contact.dart';

class DeleteContactDialog extends StatefulWidget {
  final Contact contact;
  const DeleteContactDialog({
    Key key,
    @required this.contact,
  }) : super(key: key);

  @override
  _DeleteContactDialogState createState() => _DeleteContactDialogState();
}

class _DeleteContactDialogState extends State<DeleteContactDialog> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Would you like to delete this Account?'),
            SizedBox(
              height: 25,
            ),
            Text(
              widget.contact.accountNumber.toString(),
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.contact.name,
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: Text('DELETE'),
          onPressed: () {
            dependencies.contactDao.delete(widget.contact.id).then((value) {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }
}
