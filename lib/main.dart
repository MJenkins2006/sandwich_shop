import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantityFootlong = 0;
  int _quantitySixinch = 0;

  void _increaseQuantityFootlong() {
    if (_quantityFootlong < widget.maxQuantity) {
      setState(() => _quantityFootlong++);
    }
  }

  void _decreaseQuantityFootlong() {
    if (_quantityFootlong > 0) {
      setState(() => _quantityFootlong--);
    }
  }

  void _increaseQuantitySixinch() {
    if (_quantitySixinch < widget.maxQuantity) {
      setState(() => _quantitySixinch++);
    }
  }

  void _decreaseQuantitySixinch() {
    if (_quantitySixinch > 0) {
      setState(() => _quantitySixinch--);
    }
  }

  String orderNotes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      OrderItemDisplay(
                        _quantityFootlong,
                        'Footlong',
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _increaseQuantityFootlong,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _quantityFootlong < widget.maxQuantity
                                    ? Colors.green
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(100, 36),
                              ),
                              child: const Text('Add'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: _decreaseQuantityFootlong,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _quantityFootlong == 0 ? Colors.grey : Colors.red,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(100, 36),
                              ),
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      OrderItemDisplay(
                        _quantitySixinch,
                        'Six-inch',
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _increaseQuantitySixinch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _quantitySixinch < widget.maxQuantity
                                    ? Colors.green
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(100, 36),
                              ),
                              child: const Text('Add'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: _decreaseQuantitySixinch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _quantitySixinch == 0 ? Colors.grey : Colors.red,
                                foregroundColor: Colors.white,
                                fixedSize: const Size(100, 36),
                              ),
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Order Notes',
                  hintText: 'e.g., no onions, extra pickles',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    orderNotes = value;
                  });
                },
              ),
            ),
            if (orderNotes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Notes: $orderNotes',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantityFootlong;
  final String itemType;

  const OrderItemDisplay(this.quantityFootlong, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantityFootlong $itemType sandwich(es): ${'🥪' * quantityFootlong}');
  }
}
