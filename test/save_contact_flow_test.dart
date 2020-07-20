import 'package:bytebank_2/main.dart';
import 'package:bytebank_2/screens/contact_form.dart';
import 'package:bytebank_2/screens/contacts_list.dart';
import 'package:bytebank_2/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'matchers.dart';
import 'mocks.dart';

void main() {
  group('Saving a contact', () {
    testWidgets('Find transfer icon', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(BytebankApp());
        final dashboard = find.byType(Dashboard);
        expect(dashboard, findsOneWidget);

        final transferFeatureItem = find.byWidgetPredicate((widget) =>
            featureItemMatcher(
                widget, 'Transfer', Icons.monetization_on, 'transfer'));
        expect(transferFeatureItem, findsOneWidget);
      });
    });

    testWidgets('Should save a contact', (tester) async {
      await tester.runAsync(() async {
        final mockContactDao = MockContactDao();
        await tester.pumpWidget(MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => ContactsList(
                  contactDaoTwo: mockContactDao,
                ),
            '/contact_form': (context) => ContactForm(
                  contactDaoTwo: mockContactDao,
                ),
          },
        ));

        final fabNewContact =
            find.widgetWithIcon(FloatingActionButton, Icons.add);
        expect(fabNewContact, findsOneWidget);

        await tester.tap(fabNewContact);
        await tester.pumpAndSettle();

        final contactForm = find.byType(ContactForm);
        expect(contactForm, findsOneWidget);

        final nameTextField = find.byWidgetPredicate((widget) {
          if (widget is TextField) {
            return widget.decoration.labelText == 'Full name';
          }
          return false;
        });
        expect(nameTextField, findsOneWidget);
        await tester.enterText(nameTextField, 'Flavio');

        final accountNumberTextField = find.byWidgetPredicate((widget) {
          if (widget is TextField) {
            return widget.decoration.labelText == 'Account Number';
          }
          return false;
        });
        expect(accountNumberTextField, findsOneWidget);
        await tester.enterText(accountNumberTextField, '1000');

        final createButton = find.widgetWithText(RaisedButton, 'Create');
        expect(createButton, findsOneWidget);
        await tester.tap(createButton);
        await tester.pump();

        final contactsListBack = find.byType(ContactsList);
        expect(contactsListBack, findsOneWidget);
      });
    });
  });
}
