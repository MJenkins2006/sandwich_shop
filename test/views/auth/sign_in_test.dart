import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/auth/sign_in.dart';

void main() {
  Future<void> _pumpSignIn(WidgetTester tester) async {
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

  testWidgets('renders email, password fields and buttons', (WidgetTester tester) async {
    await _pumpSignIn(tester);

    expect(find.byKey(const Key('signin-email')), findsOneWidget);
    expect(find.byKey(const Key('signin-password')), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Need an account? Register'), findsOneWidget);
  });

  testWidgets('shows validation errors when submitting empty form', (WidgetTester tester) async {
    await _pumpSignIn(tester);

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Enter email'), findsOneWidget);
    expect(find.text('Enter password'), findsOneWidget);
  });

  testWidgets('shows only password error when email is provided', (WidgetTester tester) async {
    await _pumpSignIn(tester);

    await tester.enterText(find.byKey(const Key('signin-email')), 'user@example.com');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Enter email'), findsNothing);
    expect(find.text('Enter password'), findsOneWidget);
  });

  testWidgets('navigates to sign-up route when tapping register button', (WidgetTester tester) async {
    await _pumpSignIn(tester);

    await tester.tap(find.text('Need an account? Register'));
    await tester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
  });
}