import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/about_screen.dart';

void main() {
  testWidgets('AboutScreen displays AppBar title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);
  });

  testWidgets('AboutScreen shows welcome heading and description', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));
    expect(find.text('Welcome to Sandwich Shop!'), findsOneWidget);
    expect(
      find.text('We are a family-owned business dedicated to serving the best sandwiches in town. '),
      findsOneWidget,
    );
  });

  testWidgets('AboutScreen has Padding with 16.0 and a SizedBox of height 20', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AboutScreen()));

    // Padding with EdgeInsets.all(16.0)
    final paddingFinder = find.byWidgetPredicate((widget) {
      if (widget is Padding) {
        final padding = widget.padding;
        return padding is EdgeInsets && padding == const EdgeInsets.all(16.0);
      }
      return false;
    });
    expect(paddingFinder, findsOneWidget);

    // SizedBox with height 20
    final sizedBoxFinder = find.byWidgetPredicate((widget) {
      return widget is SizedBox && widget.height == 20.0;
    });
    expect(sizedBoxFinder, findsOneWidget);
  });
}