import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import '../test_helpers.dart';

void main() {
  testWidgets('AboutScreen displays AppBar title', (WidgetTester tester) async {
    await tester.pumpWidget(testApp(const AboutScreen()));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);
  });

  testWidgets('AboutScreen shows welcome heading and description', (WidgetTester tester) async {
    await tester.pumpWidget(testApp(const AboutScreen()));
    expect(find.text('Welcome to Sandwich Shop!'), findsOneWidget);
    expect(
      find.text('We are a family-owned business dedicated to serving the best sandwiches in town. '),
      findsOneWidget,
    );
  });
}