import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';

class CartProvide with ChangeNotifier {
  int count = 0; //商品数量
  double money = 0.00; //支付金额

  List<CartGoods> goods = [];

  refreshPayMoney(count, money) {
    this.count = count;
    this.money = money;
    notifyListeners();
  }

  refreshCartGoods(List<CartGoods> goods) {
    this.goods = goods;
    notifyListeners();
  }
}
