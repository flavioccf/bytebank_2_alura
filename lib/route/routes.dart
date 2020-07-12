import 'package:bytebank_2/screens/contact_form.dart';
import 'package:bytebank_2/screens/contacts_list.dart';
import 'package:bytebank_2/screens/dashboard.dart';
import 'package:bytebank_2/screens/transaction_form.dart';
import 'package:bytebank_2/screens/transactions_list.dart';

routeList() {
  return {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => Dashboard(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/contacts_list': (context) => ContactsList(),
    '/contact_form': (context) => ContactForm(),
    '/transactions_list': (context) => TransactionsList(),
    '/transaction_form': (context) => TransactionForm()
  };
}
