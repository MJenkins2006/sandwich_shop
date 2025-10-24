import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  // 0 = Footlong, 1 = Six-inch
  int _selectedIndex = 0;

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    final isFootlongSelected = _selectedIndex == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Blue container wrapping the segmented control and the Add/Remove buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
              color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ToggleButtons(
                    isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                    onPressed: (index) {
                      // ensure only one selected
                      _selectIndex(index);
                    },
                    borderRadius: BorderRadius.circular(8),
                    selectedBorderColor: Theme.of(context).colorScheme.primary,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Footlong'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Six-inch'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Only show the selected item
                  SizedBox(
                    width: 300,
                    child: isFootlongSelected
                        ? Column(
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
                                      onPressed:
                                          _quantityFootlong < widget.maxQuantity
                                              ? _increaseQuantityFootlong
                                              : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(100, 36),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: const Text('Add'),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _quantityFootlong > 0
                                          ? _decreaseQuantityFootlong
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(100, 36),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: const Text('Remove'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
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
                                      onPressed: _quantitySixinch < widget.maxQuantity
                                          ? _increaseQuantitySixinch
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(100, 36),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      child: const Text('Add'),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: _quantitySixinch > 0
                                          ? _decreaseQuantitySixinch
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        fixedSize: const Size(100, 36),
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
            ),
            const SizedBox(height: 16),
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
    return Text(
        '$quantityFootlong $itemType sandwich(es): ${'🥪' * quantityFootlong}');
  }
}
