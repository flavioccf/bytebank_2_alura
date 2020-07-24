import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTransferFeatureItem(WidgetTester tester) async {
  final transferFeatureItem = find.byWidgetPredicate((widget) =>
      featureItemMatcher(
          widget, 'Transfer', Icons.monetization_on, 'transfer'));
  expect(transferFeatureItem, findsOneWidget);
  return tester.tap(transferFeatureItem);
}
