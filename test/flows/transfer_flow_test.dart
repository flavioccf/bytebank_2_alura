import 'package:bytebank_2/components/response_dialog.dart';
import 'package:bytebank_2/components/transaction_auth_dialog.dart';
import 'package:bytebank_2/main.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/models/transaction.dart';
import 'package:bytebank_2/screens/contacts_list.dart';
import 'package:bytebank_2/screens/dashboard.dart';
import 'package:bytebank_2/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  MockContactDao mockContactDao;
  MockTransactionWebClient mockTransactionWebClient;

  setUp(() async {
    mockContactDao = MockContactDao();
    mockTransactionWebClient = MockTransactionWebClient();
  });
  group('Transfer Flow Group: ', () {
    testWidgets('Should transfer to a contact', (tester) async {
      await tester.pumpWidget(BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: mockTransactionWebClient,
      ));
      final contact = Contact('Flavio', 1000, id: 1);
      final transaction = Transaction(null, 200, contact);
      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      when(mockContactDao.findAll()).thenAnswer((realInvocation) async {
        return [contact];
      });

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final contactItem = find.byWidgetPredicate((widget) {
        if (widget is ContactItem) {
          return widget.contact.name == contact.name &&
              widget.contact.accountNumber == contact.accountNumber;
        }
        return false;
      });
      expect(contactItem, findsOneWidget);
      await tester.tap(contactItem);
      await tester.pumpAndSettle();

      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);

      final contactName = find.text(contact.name);
      expect(contactName, findsOneWidget);
      final contactAccountNumber = find.text(contact.accountNumber.toString());
      expect(contactAccountNumber, findsOneWidget);

      await fillTextFieldWithTextLabel(tester,
          labelText: 'Value', text: transaction.value.toString());

      await clickOntheRaisedButtonWithText(tester, 'Transfer');
      await tester.pumpAndSettle();

      final transactionAuthDialog = find.byType(TransactionAuthDialog);
      expectSync(transactionAuthDialog, findsOneWidget);

      final authField = find.byKey(Key('transactionAuthField'));
      expect(authField, findsOneWidget);
      await tester.enterText(authField, 1000.toString());

      final cancelButton = find.widgetWithText(FlatButton, 'Cancel');
      expect(cancelButton, findsOneWidget);

      final confirmButton = find.widgetWithText(FlatButton, 'Confirm');
      expect(confirmButton, findsOneWidget);

      when(mockTransactionWebClient.save(transaction, '1000'))
          .thenAnswer((_) async => Future.value(transaction));

      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      final successDialog = find.byType(SuccessDialog);
      expect(successDialog, findsOneWidget);

      // final okButton = find.widgetWithText(FlatButton, 'Ok');
      // expect(okButton, findsOneWidget);

      // await tester.tap(okButton);
      // await tester.pumpAndSettle();

      // final contactsListBack = find.byType(ContactsList);
      // expect(contactsListBack, findsOneWidget);
    });
  });
}
