import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_eshop/db/DatabaseHelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    return FutureBuilder(
        future: getCartGoods(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              //DB有数据,显示列表
              return CartListView(list: snapshot.data);
            } else {
              //DB没有数据,显示空页面
              return Center(
                child: EmptyCartView(),
              );
            }
          } else {
            //正在异步获取DB内的数据
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }

  Future<List<CartGoods>> getCartGoods() async {
    var db = DatabaseHelper();
    List<Map<String, dynamic>> result = await db.getTotalList();
    List<CartGoods> datas = CartGoods.fromMapList(result);
//    await db.close();
    if (datas.isNotEmpty) {
      //购物车有物品
      return datas;
    } else {
      //购物车没有物品,显示 为空的页面
      return [];
    }
  }
}
