import 'package:bytebank_2/components/progress.dart';
import 'package:bytebank_2/dao/contact_dao.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  final ContactDao contactDao;
  ContactsList({this.contactDao});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: Future.delayed(Duration(milliseconds: 500))
            .then((value) => widget.contactDao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        '/transaction_form',
                        arguments: TransactionFormArguments(contact),
                      ).then((newTransaction) {
                        setState(() {
                          if (newTransaction != null) {
                            final snackbar = SnackBar(
                                content: Text(newTransaction.toString()));
                            Scaffold.of(context).showSnackBar(snackbar);
                          }
                          print(newTransaction);
                        });
                      });
                    },
                  );
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Center(
            child: Text('Unknown error'),
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/contact_form').then((newContact) {
              setState(() {
                final snackbar = SnackBar(content: Text(newContact.toString()));
                Scaffold.of(context).showSnackBar(snackbar);
                print(newContact);
              });
            });
          },
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  _ContactItem(
    this.contact, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    var listTile = ListTile(
      onTap: () => onClick(),
      title: Text(
        contact.name,
        style: TextStyle(
          fontSize: 24.00,
        ),
      ),
      subtitle: Text(
        contact.accountNumber.toString(),
        style: TextStyle(fontSize: 16.00),
      ),
    );
    return Card(
      child: Draggable(
        child: listTile,
        feedback: Material(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 10.00),
            child: listTile,
          ),
          elevation: 4.0,
        ),
        childWhenDragging: Container(),
      ),
    );
  }
}
