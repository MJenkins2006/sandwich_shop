import 'package:flutter/material.dart';
import 'package:sandwich_shop/services/auth_service.dart';

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
    final auth = AuthService();

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sandwich Shop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (auth.isSignedIn && auth.currentUserName != null)
                    Text('Hello, ${auth.currentUserName}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            _buildTile(context, 'About', '/about'),
            _buildTile(context, 'Orders', '/orders'),
            if (!(auth.isSignedIn)) _buildTile(context, 'Sign In', '/sign-in'),
            if (!(auth.isSignedIn)) _buildTile(context, 'Sign Up', '/sign-up'),
            _buildTile(context, 'Cart', '/cart'),
            _buildTile(context, 'Checkout', '/checkout'),
            const Spacer(),
            if (auth.isSignedIn)
              ListTile(
                title: const Text('Sign out', style: TextStyle(color: Colors.red)),
                onTap: () {
                  auth.signOut();
                  Navigator.of(context).pop();
                  // return to the orders screen root
                  Navigator.of(context).pushNamedAndRemoveUntil('/orders', (route) => false);
                },
              ),
          ],
        ),
      ),
    );
  }
}
