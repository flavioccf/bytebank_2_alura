import 'dart:async';
import 'package:bytebank_2/components/progress.dart';
import 'package:bytebank_2/components/response_dialog.dart';
import 'package:bytebank_2/components/transaction_auth_dialog.dart';
import 'package:bytebank_2/http/webclients/transaction_webclient.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionFormArguments {
  final Contact contact;

  TransactionFormArguments(this.contact);
}

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final TransactionFormArguments args =
        ModalRoute.of(context).settings.arguments;
    print(transactionId);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Sending transaction...',
                  ),
                ),
              ),
              Text(
                args.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  args.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, args.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password,
                                    _scaffold.currentContext);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _sending = true;
    });
    final Transaction newTransaction = await _send(
      transactionCreated,
      password,
      context,
    );

    _showSuccessfullMessage(newTransaction, context);
  }

  Future _showSuccessfullMessage(
      Transaction newTransaction, BuildContext context) async {
    if (newTransaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successfull transfer');
          });
      Navigator.pop(context, newTransaction);
    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    return await _webClient.save(transactionCreated, password).catchError(
        (error) {
      _showFailureMessage(context, error);
    }, test: (e) => e is HttpExceptionDif).catchError((error) {
      _showFailureMessage(context, error, message: 'Timeout');
    }, test: (e) => e is TimeoutException).catchError((error) {
      _showFailureMessage(context, error);
    }, test: (e) => e is Exception).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
  }

  void _showFailureMessage(BuildContext context, error, {String message}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog((message == null ? error.message : message));
      },
    );
  }
}
