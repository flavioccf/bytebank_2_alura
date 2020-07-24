import 'package:bytebank_2/components/centered_message.dart';
import 'package:bytebank_2/components/progress.dart';
import 'package:bytebank_2/extensions/string_extension.dart';
import 'package:bytebank_2/models/transaction.dart';
import 'package:bytebank_2/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: List(),
        future: Future.delayed(Duration(milliseconds: 500))
            .then((value) => dependencies.transactionWebClient.findAll()),
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
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.name.toString().capitalize() +
                                ': ' +
                                transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage('No transactions found',
                  icon: Icons.warning);

              break;
          }
          return CenteredMessage('Unknown Error');
        },
      ),
    );
  }
}
