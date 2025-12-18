import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sandwich_shop/main.dart' as app;
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/widgets/common_widgets.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('add a sandwich to the cart and verify it is in the cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Test the initial state of the app (on the order screen)
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsWidgets);

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton); // Scroll if needed
      await tester.pumpAndSettle();

      // Add a sandwich to the cart
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      // Verify cart summary updated
      expect(find.text('Cart: 1 items - £11.00'), findsOneWidget);

      // Find the View Cart button to navigate to the cart
      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.pumpAndSettle();
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      // Verify that we're on the cart screen and the sandwich is there
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Total: £11.00'), findsOneWidget);
    });

    testWidgets('change sandwich type and add to cart',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final sandwichDropdown = find.byType(DropdownMenu<SandwichType>);
      await tester.tap(sandwichDropdown);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chicken Teriyaki').last);
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();

      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.pumpAndSettle();

      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
    });

    testWidgets('modify quantity and add to cart', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final quantitySection = find.text('Quantity: ');
      expect(quantitySection, findsOneWidget);

      // Find the + button that's near the quantity text
      final addButtons = find.byIcon(Icons.add);
      // The + button should be the first one (before the cart + button)
      final quantityAddButton = addButtons.first;

      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();
      await tester.tap(quantityAddButton);
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.pumpAndSettle();

      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      expect(find.text('Cart: 3 items - £33.00'), findsOneWidget);
    });

    testWidgets('complete checkout flow', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pumpAndSettle();

      // Wait for payment processing (2 seconds + buffer)
      await tester.pump(const Duration(seconds: 3));

      // Should be back on order screen with empty cart
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.text('Cart: 0 items - £0.00'), findsOneWidget);
    });

    // Feel free to add more tests (e.g., to check saved orders, etc.)

    testWidgets('saved order appears in order history', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Add one sandwich and go to checkout
      final addToCartButton = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pumpAndSettle();

      final viewCartButton = find.widgetWithText(StyledButton, 'View Cart');
      await tester.ensureVisible(viewCartButton);
      await tester.tap(viewCartButton);
      await tester.pumpAndSettle();

      final checkoutButton = find.widgetWithText(StyledButton, 'Checkout');
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      final confirmPaymentButton = find.text('Confirm Payment');
      await tester.tap(confirmPaymentButton);
      await tester.pump(const Duration(seconds: 3));

      // Back on order screen, open order history
      final orderHistoryButton = find.widgetWithText(StyledButton, 'Order History');
      await tester.ensureVisible(orderHistoryButton);
      await tester.tap(orderHistoryButton);
      await tester.pumpAndSettle();

      // The order history should show the recently saved order and total amount
      expect(find.text('Order History'), findsOneWidget);
      expect(find.text('£11.00'), findsWidgets);
      expect(find.text('1 items'), findsWidgets);
    });

    testWidgets('profile save shows welcome message', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Open Profile screen
      final profileButton = find.widgetWithText(StyledButton, 'Profile');
      await tester.ensureVisible(profileButton);
      await tester.tap(profileButton);
      await tester.pumpAndSettle();

      // Fill in name and location
      final nameField = find.byType(TextField).at(0);
      final locationField = find.byType(TextField).at(1);

      await tester.enterText(nameField, 'Alice');
      await tester.enterText(locationField, 'Downtown');
      await tester.pumpAndSettle();

      // Save profile
      final saveButton = find.widgetWithText(ElevatedButton, 'Save Profile');
      await tester.ensureVisible(saveButton);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Expect welcome snackbar on Order screen
      final welcomeMessage = find.text('Welcome, Alice! Ordering from Downtown');
      // SnackBar may be transient; give it a short time to appear
      await tester.pump(const Duration(milliseconds: 500));
      expect(welcomeMessage, findsOneWidget);
    });

    testWidgets('settings slider updates current size', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Open Settings screen
      final settingsButton = find.widgetWithText(StyledButton, 'Settings');
      await tester.ensureVisible(settingsButton);
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Should show Settings header and current size text
      expect(find.text('Settings'), findsOneWidget);
      final currentSizeText = find.textContaining('Current size:');
      expect(currentSizeText, findsOneWidget);

      // Drag the slider to increase size
      final slider = find.byType(Slider);
      expect(slider, findsOneWidget);

      // Drag to the right to increase value; a positive dx moves the thumb
      await tester.drag(slider, const Offset(120, 0));
      await tester.pumpAndSettle();

      // The current size should no longer be the default 16px
      expect(find.text('Current size: 16px'), findsNothing);
    });
  });
}