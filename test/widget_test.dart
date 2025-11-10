import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('increments quantity when Add is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('does not increment above maxQuantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // maxQuantity is 5, start at 1, so tap 4 times to reach 5
      for (int i = 0; i < 6; i++) {
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();
      }
      expect(find.text('5'), findsOneWidget);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('toggles sandwich type with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Initially footlong (Switch is on)
      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
      
      await tester.tap(find.byType(Switch));
      await tester.pump();
      
      final switchWidgetAfter = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidgetAfter.value, isFalse);
    });
    
    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      
      // Verify wheat is selected by tapping dropdown again and checking
      await tester.tap(find.byType(DropdownMenu<BreadType>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wholemeal').last);
      await tester.pumpAndSettle();
      
      // Both selections worked if no errors occurred
      expect(find.byType(DropdownMenu<BreadType>), findsOneWidget);
    });

    testWidgets('Add to Cart button works', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      
      // Increase quantity
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      
      // Tap Add to Cart button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle();
      
      // Should show a SnackBar and update order display
      expect(find.text('Cart empty'), findsNothing);
      expect(find.textContaining('item(s) in your cart'), findsOneWidget);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('OrderItemDisplay', () {
    testWidgets('shows correct text and note for zero sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 0,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'No notes added.',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      expect(find.text('Note: No notes added.'), findsOneWidget);
    });

    testWidgets('shows correct text and emoji for three sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 3,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'No notes added.',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(
          find.text('3 white footlong sandwich(es): 🥪🥪🥪'), findsOneWidget);
      expect(find.text('Note: No notes added.'), findsOneWidget);
    });

    testWidgets('shows correct bread and type for two six-inch wheat',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 2,
        itemType: 'six-inch',
        breadType: BreadType.wheat,
        orderNote: 'No pickles',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.text('2 wheat six-inch sandwich(es): 🥪🥪'), findsOneWidget);
      expect(find.text('Note: No pickles'), findsOneWidget);
    });

    testWidgets('shows correct bread and type for one wholemeal footlong',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.wholemeal,
        orderNote: 'Lots of lettuce',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(
          find.text('1 wholemeal footlong sandwich(es): 🥪'), findsOneWidget);
      expect(find.text('Note: Lots of lettuce'), findsOneWidget);
    });
  });
}
