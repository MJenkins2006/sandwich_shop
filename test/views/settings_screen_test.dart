import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/views/settings_screen.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  group('SettingsScreen', () {
    testWidgets('loads font size from preferences and displays it',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'fontSize': 20.0});

      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Current size: 20px'), findsOneWidget);
      expect(AppStyles.baseFontSize, 20.0);
    });

  });
}
