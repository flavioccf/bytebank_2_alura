import 'package:bytebank_2/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the value when creatingg a transaction', () {
    final Transaction transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });
  test('Should return error when creating transaction with value lower than 1',
      () {
    expect(() => Transaction(null, 0, null), throwsAssertionError);
  });
}
