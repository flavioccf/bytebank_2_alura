import 'package:bytebank_2/main.dart';
import 'package:bytebank_2/models/contact.dart';
import 'package:bytebank_2/screens/contact_form.dart';
import 'package:bytebank_2/screens/contacts_list.dart';
import 'package:bytebank_2/screens/dashboard.dart';
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
  group('Save Contact Group: ', () {
    testWidgets('Finding transfer icon', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(BytebankApp(
          contactDao: mockContactDao,
          transactionWebClient: mockTransactionWebClient,
        ));

        final dashboard = find.byType(Dashboard);
        expect(dashboard, findsOneWidget);

        final transferFeatureItem = find.byWidgetPredicate((widget) =>
            featureItemMatcher(
                widget, 'Transfer', Icons.monetization_on, 'transfer'));
        expect(transferFeatureItem, findsOneWidget);
      });
    });

    testWidgets('Saving a contact', (tester) async {
      final contact = Contact('Flavio', 1000, id: 1);
      await tester.pumpWidget(BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: mockTransactionWebClient,
      ));

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      await clickOnTheFabNew(tester);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);

      await fillTextFieldWithTextLabel(tester,
          labelText: 'Full name', text: contact.name);

      await fillTextFieldWithTextLabel(tester,
          labelText: 'Account Number', text: contact.accountNumber.toString());

      await clickOntheRaisedButtonWithText(tester, 'Create');
      await tester.pumpAndSettle();

      verify(mockContactDao.save(contact)).called(1);

      final contactsListBack = find.byType(ContactsList);
      expect(contactsListBack, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);
    });
  });
}
