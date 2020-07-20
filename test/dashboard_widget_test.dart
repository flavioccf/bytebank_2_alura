import 'package:bytebank_2/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';

void main() {
  group('When Dashboard opens', () {
    testWidgets('Should display main image when Dashboard screen is opened',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets(
        'Should display Transfer FeatureItem when Dashboard screen is opened',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final transferFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(
              widget, 'Transfer', Icons.monetization_on, 'transfer'));

      expect(transferFeatureItem, findsOneWidget);
    });

    testWidgets(
        'Should display Transaction Feed FeatureItem when Dashboard screen is opened',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(widget, 'Transaction Feed', Icons.description,
              'transaction_feed'));
      expect(transactionFeedFeatureItem, findsOneWidget);
    });
  });
}
