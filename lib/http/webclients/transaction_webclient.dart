import 'dart:convert';

import 'package:bytebank_2/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank_2/http/webclient.dart';

class TransactionWebClient {
  static const String baseUrl = 'http://192.168.15.15:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 25));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic transactionJson) => Transaction.fromJson(transactionJson))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
