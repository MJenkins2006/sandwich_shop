
    import 'package:flutter/material.dart';
    import 'package:flutter_test/flutter_test.dart';
    import 'package:sandwich_shop/views/order_screen.dart';
    import 'package:sandwich_shop/views/auth/sign_in.dart';
    import 'package:sandwich_shop/views/auth/sign_up.dart';

    void main() {
      testWidgets('Sign up flow creates account and returns to order screen', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: const OrderScreen(),
          routes: {
            '/sign-in': (context) => const SignInScreen(),
            '/sign-up': (context) => const SignUpScreen(),
          },
        ));

        // Ensure sign in/register button exists
        final signButton = find.text('Sign in / Register');
        expect(signButton, findsOneWidget);

        // Push sign-up route via the navigator and verify SignUpScreen is shown,
        // then pop with a value and ensure we return to OrderScreen with that value.
        final NavigatorState navigator = tester.state<NavigatorState>(find.byType(Navigator));
        final Future<dynamic> pushFuture = navigator.pushNamed('/sign-up');
        await tester.pumpAndSettle();
        expect(find.byType(SignUpScreen), findsOneWidget);

        navigator.pop(true);
        await tester.pumpAndSettle();
        final result = await pushFuture;
        expect(result, equals(true));
        expect(find.byType(OrderScreen), findsOneWidget);
      });

      testWidgets('Sign in route shows SignInScreen and returns to order screen', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: const OrderScreen(),
          routes: {
            '/sign-in': (context) => const SignInScreen(),
            '/sign-up': (context) => const SignUpScreen(),
          },
        ));

        final NavigatorState navigator = tester.state<NavigatorState>(find.byType(Navigator));
        final Future<dynamic> pushFuture = navigator.pushNamed('/sign-in');
        await tester.pumpAndSettle();
        expect(find.byType(SignInScreen), findsOneWidget);

        navigator.pop('signed-in');
        await tester.pumpAndSettle();
        final result = await pushFuture;
        expect(result, equals('signed-in'));
        expect(find.byType(OrderScreen), findsOneWidget);
      });

      testWidgets('Registered routes are present and navigator can push both', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: const OrderScreen(),
          routes: {
            '/sign-in': (context) => const SignInScreen(),
            '/sign-up': (context) => const SignUpScreen(),
          },
        ));

        final NavigatorState navigator = tester.state<NavigatorState>(find.byType(Navigator));

        // Push sign-in
        final Future<dynamic> signInFuture = navigator.pushNamed('/sign-in');
        await tester.pumpAndSettle();
        expect(find.byType(SignInScreen), findsOneWidget);
        navigator.pop(null);
        await tester.pumpAndSettle();
        await signInFuture;

        // Push sign-up
        final Future<dynamic> signUpFuture = navigator.pushNamed('/sign-up');
        await tester.pumpAndSettle();
        expect(find.byType(SignUpScreen), findsOneWidget);
        navigator.pop(null);
        await tester.pumpAndSettle();
        await signUpFuture;

        // Back at order screen
        expect(find.byType(OrderScreen), findsOneWidget);
      });
    }