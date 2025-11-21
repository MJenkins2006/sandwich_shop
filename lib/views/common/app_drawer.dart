import 'package:flutter/material.dart';

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
              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sandwich Shop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            _buildTile(context, 'About', '/about'),
            _buildTile(context, 'Sandwich Counter', '/orders'),
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
