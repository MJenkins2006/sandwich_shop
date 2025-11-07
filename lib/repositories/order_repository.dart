class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;

  OrderRepository({required this.maxQuantity});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;
  bool get canDecrement => _quantity > 0;

  void increment() {
    if (canIncrement) {
      _quantity++;
    }
  }

  void decrement() {
    if (canDecrement) {
      _quantity--;
    }
  }

  int getPrice(String itemType) {
    int price;
    if (itemType == 'six-inch') {
      price = 7 * quantity;
    } else {
      price = 11 * quantity;
    }
    return price;
  }
}