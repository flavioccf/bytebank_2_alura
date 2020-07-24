import 'package:bytebank_2/main.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/screens/contacts_list.dart';
import 'package:bytebank_2/screens/dashboard.dart';
import 'package:bytebank_2/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
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

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      when(mockContactDao.findAll()).thenAnswer((realInvocation) async {
        return [Contact('Flavio', 1000, id: 1)];
      });

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final contactItem = find.byWidgetPredicate((widget) {
        if (widget is ContactItem) {
          return widget.contact.name == 'Flavio' &&
              widget.contact.accountNumber == 1000;
        }
        return false;
      });
      expect(contactItem, findsOneWidget);
      await tester.tap(contactItem);
      await tester.pumpAndSettle();

      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);
    });
  });
}
