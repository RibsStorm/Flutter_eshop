import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';

import 'provide/cart_provide.dart';
import 'view/cart_bottom_view.dart';
import 'view/cart_empty_view.dart';

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
        future: getCartGoods(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> goods = Provide.value<CartProvide>(context).goods;
            if (goods.isNotEmpty) {
              return bodyView();
            } else {
              return Center(
                child: EmptyCartView(),
              );
            }
          } else {
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.blueAccent,
              ),
            );
          }
        });
  }

  Future getCartGoods(BuildContext context) async {
    await Provide.value<CartProvide>(context).refreshCartData();
    return "获取购物车数据成功";
  }

  Widget bodyView() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(1334),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
            child: Text("sdsads"),
          ),

          //底部结算栏.
          Positioned(
              bottom: 0.0,
              left: 0.0,
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(80),
              child: CartBottomView(),
          )
        ],
      ),
    );
  }
}
