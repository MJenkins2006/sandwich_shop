import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sandwich_shop/views/app_styles.dart';

void main() {
	group('AppStyles', () {
		test('text styles reflect base font size and weights', () async {
			SharedPreferences.setMockInitialValues({'fontSize': 18.0});

			await AppStyles.loadFontSize();

			expect(AppStyles.baseFontSize, 18.0);

			expect(AppStyles.normalText.fontSize, equals(18.0));
			expect(AppStyles.heading1.fontSize, equals(26.0)); // base + 8
			expect(AppStyles.heading2.fontSize, equals(22.0)); // base + 4

			expect(AppStyles.heading1.fontWeight, equals(FontWeight.bold));
			expect(AppStyles.heading2.fontWeight, equals(FontWeight.bold));
		});
	});
}

