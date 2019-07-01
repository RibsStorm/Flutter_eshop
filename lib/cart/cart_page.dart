import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'provide/cart_provide.dart';
import 'view/cart_empty_view.dart';
import 'view/cart_item_view.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: cartView(context),
    );
  }

  Widget cartView(context) {
    Provide.value<CartProvide>(context).getAllCartGoods();

    return Provide<CartProvide>(builder: (context, child, data) {
      if (data.goods.isNotEmpty) {
        return CartListView();
      } else {
        //DB没有数据,显示空页面
        return Center(
          child: EmptyCartView(),
        );
      }
    });
  }
}
