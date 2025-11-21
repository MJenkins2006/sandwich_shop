import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/sign_in_screen.dart';
import 'package:sandwich_shop/views/sign_up_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      home: const OrderScreen(maxQuantity: 5),
      routes: {
        '/orders': (context) => const OrderScreen(maxQuantity: 5),
        '/about': (context) => const AboutScreen(),
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/cart': (context) => CartScreen(cart: Cart()),
        '/checkout': (context) => CheckoutScreen(cart: Cart()),
      },
    );
  }
}