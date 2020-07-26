import 'package:bytebank_2/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon, String key) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon && widget.key == Key(key);
  }
  return false;
}

bool textFieldByLabelTextMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}

Future<void> clickOntheRaisedButtonWithText(
    WidgetTester tester, String text) async {
  final createButton = find.widgetWithText(RaisedButton, text);
  expect(createButton, findsOneWidget);
  return tester.tap(createButton);
}

Future<void> fillTextFieldWithTextLabel(
  WidgetTester tester, {
  String text = '',
  @required String labelText,
}) async {
  final nameTextField = find.byWidgetPredicate(
      (widget) => textFieldByLabelTextMatcher(widget, labelText));
  expect(nameTextField, findsOneWidget);
  return tester.enterText(nameTextField, text);
}

Future<void> clickOnTheFabNew(WidgetTester tester) async {
  final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
  expect(fabNewContact, findsOneWidget);
  return tester.tap(fabNewContact);
}
