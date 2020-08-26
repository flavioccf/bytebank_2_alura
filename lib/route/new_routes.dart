import 'package:bytebank_2/route/route_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String root = "/";
  static String contactsList = '/contacts_list';
  static String contactForm = '/contact_form';
  static String transactionsLits = '/transactions_list';
  static String transactionForm = '/transaction_form';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
  }
}
