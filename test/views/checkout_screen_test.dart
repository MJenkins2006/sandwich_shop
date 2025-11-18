import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CheckoutScreen widget tests', () {
    testWidgets('renders basic static elements', (WidgetTester tester) async {
      final Cart cart = Cart(); // expected to exist in project

      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      // AppBar title
      expect(find.text('Checkout'), findsOneWidget);

      // Order Summary heading
      expect(find.text('Order Summary'), findsOneWidget);

      // Payment method text
      expect(find.textContaining('Payment Method'), findsOneWidget);

      // Confirm Payment button present
      expect(find.text('Confirm Payment'), findsOneWidget);
    });

    testWidgets('process payment shows progress indicator and returns confirmation',
        (WidgetTester tester) async {
      final Cart cart = Cart();

      Map<dynamic, dynamic>? confirmation;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(builder: (context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push<Map<dynamic, dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(cart: cart),
                    ),
                  ).then((value) {
                    confirmation = value;
                  });
                },
                child: const Text('Open Checkout'),
              ),
            );
          }),
        ),
      );

      // Open the checkout screen
      await tester.tap(find.text('Open Checkout'));
      await tester.pumpAndSettle();

      // Tap confirm payment
      expect(find.text('Confirm Payment'), findsOneWidget);
      await tester.tap(find.text('Confirm Payment'));

      // Let the first frame update show the processing state
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing payment...'), findsOneWidget);

      // Advance fake time to allow the async delay in _processPayment to complete
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // After processing, the screen should have been popped and confirmation set
      expect(confirmation, isNotNull);
      expect(confirmation, isA<Map>());

      // Check expected keys in the returned confirmation map
      expect(confirmation!.containsKey('orderId'), isTrue);
      expect(confirmation!.containsKey('totalAmount'), isTrue);
      expect(confirmation!.containsKey('itemCount'), isTrue);
      expect(confirmation!.containsKey('estimatedTime'), isTrue);
    });
  });
}