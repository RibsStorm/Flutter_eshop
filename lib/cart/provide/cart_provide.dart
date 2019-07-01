import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_eshop/db/DatabaseHelper.dart';

class CartProvide with ChangeNotifier {
  int count = 0; //商品数量
  double money = 0.00; //支付金额

  List<CartGoods> goods = [];

  refreshPayMoney(count, money) {
    this.count = count;
    this.money = money;
    notifyListeners();
  }

//获取db内所有 购物车商品信息
  getAllCartGoods() async {
    var db = DatabaseHelper();
    List<Map<String, dynamic>> result = await db.getTotalList();
    if (goods.isNotEmpty) goods.clear();
    goods = CartGoods.fromMapList(result);
    notifyListeners();
  }

//更新购物车商品信息,同步更新数据库信息
  refreshCartGoods(CartGoods item) async {
    this.goods.remove(item);
    var db = DatabaseHelper();
    await db.deleteItem(item.goodsId);

    notifyListeners();
  }

  refreshAllCartGoods(List<CartGoods> goods) async {
    this.goods = goods;
    var db = DatabaseHelper();
    goods.forEach((item) {
      db.updateItemForSelect(item.isSelect, item.goodsId);
    });
    notifyListeners();
  }

  refreshCartInfo(int count, double money) {
    this.count = count;
    this.money = money;
  }
}
