import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/views/common/app_drawer.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  double _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  Future<void> _navigateToCheckout() async {
    if (widget.cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cart: widget.cart),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        widget.cart.clear();
      });

      final String orderId = result['orderId'] as String;
      final String estimatedTime = result['estimatedTime'] as String;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Order $orderId confirmed! Estimated time: $estimatedTime'),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: 'Open navigation menu',
          );
        }),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 36,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const Text(
              'Cart View',
              style: heading1,
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              if (widget.cart.isEmpty) ...[
                const SizedBox(height: 40),
                Icon(Icons.remove_shopping_cart, size: 72, color: Colors.grey[600]),
                const SizedBox(height: 12),
                const Text('Your cart is empty', style: heading2, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                const Text(
                  'Add items from the order screen before checking out.',
                  style: normalText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: StyledButton(
                    onPressed: _goBack,
                    icon: Icons.arrow_back,
                    label: 'Back to Order',
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Keep legacy total text for compatibility with tests and callers
                Text(
                  'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                  style: heading2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ] else ...[
                for (MapEntry<Sandwich, int> entry in widget.cart.items.entries)
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.key.name, style: heading2),
                                Text(
                                  '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                                  style: normalText,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: entry.value > 0
                                    ? () {
                                        final Sandwich sandwich = entry.key;
                                        final int previousQty = entry.value;
                                        setState(() {
                                          widget.cart.decrement(sandwich);
                                        });

                                        final int newQty = previousQty - 1;
                                        if (newQty <= 0) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Removed ${sandwich.name} from cart'),
                                              action: SnackBarAction(
                                                label: 'UNDO',
                                                onPressed: () {
                                                  setState(() {
                                                    widget.cart.add(sandwich, quantity: previousQty);
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Updated ${sandwich.name} quantity to $newQty'),
                                              duration: const Duration(seconds: 1),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                              ),
                              Text('${entry.value}', style: heading2),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  final Sandwich sandwich = entry.key;
                                  final int previousQty = entry.value;
                                  setState(() {
                                    widget.cart.add(sandwich);
                                  });
                                  final int newQty = previousQty + 1;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Updated ${sandwich.name} quantity to $newQty'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.redAccent,
                            tooltip: 'Remove item',
                            onPressed: () {
                              final Sandwich sandwich = entry.key;
                              final int removedQty = entry.value;
                              setState(() {
                                widget.cart.removeItem(sandwich);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Removed ${sandwich.name} from cart'),
                                  action: SnackBarAction(
                                    label: 'UNDO',
                                    onPressed: () {
                                      setState(() {
                                        widget.cart.add(sandwich, quantity: removedQty);
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '£${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                            style: normalText,
                          ),
                        // Legacy formatted line for tests and backward compatibility
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Qty: ${entry.value} - £${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                            style: normalText,
                          ),
                        ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                  style: heading2,
                  textAlign: TextAlign.center,
                ),
                Builder(
                  builder: (BuildContext context) {
                    final bool cartHasItems = widget.cart.items.isNotEmpty;
                    if (cartHasItems) {
                      return StyledButton(
                        onPressed: _navigateToCheckout,
                        icon: Icons.payment,
                        label: 'Checkout',
                        backgroundColor: Colors.orange,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 20),
                StyledButton(
                  onPressed: _goBack,
                  icon: Icons.arrow_back,
                  label: 'Back to Order',
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
