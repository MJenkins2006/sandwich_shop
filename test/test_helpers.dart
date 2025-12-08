import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';

Widget testApp(Widget home, {Map<String, WidgetBuilder>? routes}) {
  return ChangeNotifierProvider<Cart>(
    create: (_) => Cart(),
    child: MaterialApp(
      routes: routes ?? const {},
      home: home,
    ),
  );
}
