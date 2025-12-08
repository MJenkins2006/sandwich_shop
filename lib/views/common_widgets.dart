import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildTile(BuildContext context, String label, String routeName) {
    return ListTile(
      title: Text(label),
      onTap: () {
        Navigator.of(context).pop();
        // For cart/checkout we navigate to named routes if available
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColorLight),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sandwich Shop',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            _buildTile(context, 'About', '/about'),
            _buildTile(context, 'Sandwich Counter', '/'),
            _buildTile(context, 'Sign In', '/sign-in'),
            _buildTile(context, 'Sign Up', '/sign-up'),
            _buildTile(context, 'Cart', '/cart'),
            _buildTile(context, 'Checkout', '/checkout'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context, String title, {bool showDrawerIcon = true}) {
  return AppBar(
    title: Text(
      title,
      style: heading1,
    ),
    actions: [
      Consumer<Cart>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 4),
                Text('${cart.countOfItems}'),
              ],
            ),
          );
        },
      ),
    ],
  );
}
