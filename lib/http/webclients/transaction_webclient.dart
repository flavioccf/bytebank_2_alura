import 'dart:convert';
import 'package:bytebank_2/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank_2/http/webclient.dart';

class TransactionWebClient {
  static const String baseUrl = 'http://192.168.15.15:8080/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic transactionJson) => Transaction.fromJson(transactionJson))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client
        .post(
          baseUrl,
          headers: {
            'Content-type': 'application/json',
            'password': password,
          },
          body: transactionJson,
        )
        .timeout(Duration(seconds: 5));

    if ([200, 201, 202, 203, 204].contains(response.statusCode)) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      final String exceptionMessage = _statusCodeResponses[response.statusCode];
      print(exceptionMessage);
      print(response.statusCode);
      if (exceptionMessage != null) {
        throw HttpExceptionDif(_statusCodeResponses[response.statusCode]);
      } else {
        throw Exception('Unkown error');
      }
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    404: 'Page not found',
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    409: 'Duplicate entry for this transaction',
  };
}

class HttpExceptionDif implements Exception {
  final String message;

  HttpExceptionDif(this.message);
}
