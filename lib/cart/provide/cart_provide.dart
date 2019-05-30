import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  List<Map> goods = [];
  int count = 0; //商品数量
  double money = 0.00; //支付金额

  refreshCartData() async {
//TODO...数据转换有点问题,如何把数据从KEY-VALUE结构转换成MODEL类型,通过fromJson为什么不行
    SharedPreferences sp = await SharedPreferences.getInstance();
    String data = sp.getString('cartInfo');
    var temp = data == null ? [] : json.decode(data);
    if (temp == null) {
      goods = [];
    } else {
      goods = (temp as List).cast();
    }
    notifyListeners();
  }

  refreshPayMoney(count, money) {
    this.count = count;
    this.money = money;
    notifyListeners();
  }
}
