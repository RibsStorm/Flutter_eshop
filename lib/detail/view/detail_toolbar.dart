import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          shoppingCart(),
          joinCart(),
          buyNow(),
        ],
      ),
    );
  }

  Widget shoppingCart() {
    return Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setHeight(120),
      color: Colors.white,
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          //TODO...商品加入购物车逻辑
        },
      ),
    );
  }

  Widget joinCart() {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(80),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: InkWell(
        onTap: () {
          //TODO...商品加入购物车逻辑
        },
        child: Text(
          "加入购物车",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(36.0), color: Colors.white),
        ),
      ),
    );
  }

  Widget buyNow() {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(80),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: InkWell(
        onTap: () {
          //TODO...商品立即买买买的逻辑
        },
        child: Text(
          "立即购买",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(36.0), color: Colors.white),
        ),
      ),
    );
  }
}
