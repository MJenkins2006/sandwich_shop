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

    testWidgets('updates font size when slider moved and saves to prefs',
        (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'fontSize': 16.0});

      await tester.pumpWidget(
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );
      await tester.pumpAndSettle();

      final sliderFinder = find.byType(Slider);
      expect(sliderFinder, findsOneWidget);

      final RenderBox sliderBox = tester.firstRenderObject(sliderFinder);
      final Offset sliderTopLeft = sliderBox.localToGlobal(Offset.zero);
      final double sliderWidth = sliderBox.size.width;

      const double targetValue = 22.0;
      const double min = 12.0;
      const double max = 24.0;
      const double fraction = (targetValue - min) / (max - min);

      final Offset tapOffset =
          sliderTopLeft + Offset(sliderWidth * fraction, sliderBox.size.height / 2);

      await tester.tapAt(tapOffset);
      await tester.pumpAndSettle();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      expect(prefs.getDouble('fontSize'), equals(targetValue));
      expect(AppStyles.baseFontSize, equals(targetValue));
      expect(find.text('Current size: ${targetValue.toInt()}px'), findsOneWidget);
    });
  });
}
