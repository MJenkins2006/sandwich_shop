import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/views/order_screen.dart';

void main() {
  group('Drawer tests', () {
    testWidgets('Drawer opens and navigates to Sign In', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // open the drawer via the menu icon
      final Finder menuButton = find.byIcon(Icons.menu);
      expect(menuButton, findsWidgets);
      await tester.tap(menuButton.first);
      await tester.pumpAndSettle();

      // Tap the Sign In item
      final Finder signInTile = find.text('Sign In');
      expect(signInTile, findsWidgets);
      // choose the drawer tile version (ListTile inside Drawer)
      await tester.tap(signInTile.first);
      await tester.pumpAndSettle();

      // We should be on the Sign In screen (AppBar title 'Sign In')
      expect(find.text('Need an account? Register'), findsWidgets);
    });

    testWidgets('Drawer shows all items', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // open the drawer via the menu icon
      final Finder menuButton = find.byIcon(Icons.menu);
      expect(menuButton, findsWidgets);
      await tester.tap(menuButton.first);
      await tester.pumpAndSettle();

      // Check for all expected drawer items
      expect(find.text('About'), findsWidgets);
      expect(find.text('Sandwich Counter'), findsWidgets);
      expect(find.text('Sign In'), findsWidgets);
      expect(find.text('Sign Up'), findsWidgets);
      expect(find.text('Cart'), findsWidgets);
      expect(find.text('Profile'), findsWidgets);

    });
  });
  group('AppBar tests', () {
    testWidgets('AppBar shows all items', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Check for AppBar title on the home screen
      expect(find.text('Sandwich Counter'), findsWidgets);

      // Check for image logo
      expect(find.byWidgetPredicate(
          (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/images/logo.png',
        ),
        findsOneWidget,
      );

      // Check for shopping cart icon
      expect(find.byIcon(Icons.shopping_cart), findsWidgets);
    });
  
    testWidgets('Cart amount changes', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Shopping cart icon should display 0 items initially then 4 after adding items
      expect(find.text('0'), findsWidgets);
      final Finder adder = find.widgetWithText(StyledButton, 'Add to Cart');
      await tester.ensureVisible(adder);
      await tester.tap(adder);
      await tester.pumpAndSettle();
      await tester.tap(adder);
      await tester.pumpAndSettle();
      await tester.tap(adder);
      await tester.pumpAndSettle();
      await tester.tap(adder);
      await tester.pumpAndSettle();

      // open the drawer via the menu icon
      final Finder menuButton = find.byIcon(Icons.menu);
      expect(menuButton, findsWidgets);
      await tester.tap(menuButton.first);
      await tester.pumpAndSettle();

      // Tap the Sign In item
      final Finder signInTile = find.text('Sign In');
      expect(signInTile, findsWidgets);
      // choose the drawer tile version (ListTile inside Drawer)
      await tester.tap(signInTile.first);
      await tester.pumpAndSettle();

      expect(find.text('Need an account? Register'), findsWidgets);
      expect(find.text('4'), findsWidgets);
    });
  });
}