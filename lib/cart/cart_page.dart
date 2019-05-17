import 'package:flutter/material.dart';

import 'view/cart_empty_view.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyCartView(),
    );
  }
}
