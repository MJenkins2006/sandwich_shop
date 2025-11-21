import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';

void main() {
  Future<void> pumpSignIn(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/sign-up': (context) => const Scaffold(body: Center(child: Text('Sign Up'))),
        },
        home: const SignInScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }
  testWidgets('navigates to sign-up route when tapping register button', (WidgetTester tester) async {
    await pumpSignIn(tester);

    await tester.tap(find.text('Need an account? Register'));
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('Shows sign in button', (WidgetTester tester) async {
    await pumpSignIn(tester);

    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('Shows Email and Password textboxes', (WidgetTester tester) async {
    await pumpSignIn(tester);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
  testWidgets('Shows error texts', (WidgetTester tester) async {
    await pumpSignIn(tester);

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Enter email'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
  });
}