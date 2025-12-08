import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';
import 'package:sandwich_shop/views/sign_up_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStyles.loadFontSize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return Cart();
      },
      child: MaterialApp(
        title: 'Sandwich Shop App',
        debugShowCheckedModeBanner: false,
        home: const OrderScreen(maxQuantity: 5),
        routes: {
          '/about': (context) => const AboutScreen(),
          '/orders': (context) => const OrderScreen(),
          '/sign-in': (context) => const SignInScreen(),
          '/sign-up': (context) => const SignUpScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
      ),
    );
  }
}