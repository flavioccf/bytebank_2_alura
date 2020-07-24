import 'package:bytebank_2/dao/contact_dao.dart';
import 'package:bytebank_2/http/webclients/transaction_webclient.dart';
import 'package:bytebank_2/route/routes.dart';
import 'package:bytebank_2/theme/theme.dart';
import 'package:bytebank_2/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    @required this.contactDao,
    @required this.transactionWebClient,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      transactionWebClient: transactionWebClient,
      contactDao: contactDao,
      child: MaterialApp(
          initialRoute: '/',
          routes: routeList(),
          theme: appTheme(),
          darkTheme: darkTheme()),
    ); //MaterialApp
  }
}
