import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/services/auth_service.dart';

void main() {
  setUp(() {
    // ensure signed out before each test
    AuthService().signOut();
  });

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
    expect(find.text('Sign In'), findsWidgets);
  });
}