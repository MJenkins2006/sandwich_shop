import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/auth/sign_up.dart';

void main() {
  Future<void> pumpSignIn(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/sign-up': (context) => const Scaffold(body: Center(child: Text('Sign Up'))),
        },
        home: const SignUpScreen(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Shows create account button', (WidgetTester tester) async {
    await pumpSignIn(tester);

    expect(find.text('Create account'), findsOneWidget);
  });

  testWidgets('Shows Email and Password textboxes', (WidgetTester tester) async {
    await pumpSignIn(tester);

    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
  
}