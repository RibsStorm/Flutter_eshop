import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../cart/provide/cart_provide.dart';
import '../../db/DatabaseHelper.dart';
import '../../util/ToastUtil.dart';
import '../model/goods.dart';
import '../provide/detail_provide.dart';

class DetailToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          shoppingCart(),
          joinCart(context),
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
          //TODO...点击跳转至 购物车页面
        },
      ),
    );
  }

  Widget joinCart(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(80),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: InkWell(
        onTap: () {
          saveToDB(context);
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

  ///点击加入购物车,将商品添加到database内.
  saveToDB(BuildContext context) async {
    //获取当前页面的信息
    Goods goods = Provide.value<DetailProvide>(context).goods;
    //初始化db,获取db内集合
    var db = DatabaseHelper();
    int count = await db.getItemCount(goods.goodInfo.goodsId);
    if (count == null) {
      //如果为null,说明现在db里面没有,直接插入
      CartGoods data = CartGoods();
      data.goodsId = goods.goodInfo.goodsId;
      data.goodsName = goods.goodInfo.goodsName;
      data.count = 1;
      data.price = goods.goodInfo.presentPrice;
      data.oldPrice = goods.goodInfo.oriPrice;
      data.images = goods.goodInfo.image1;
      data.isSelect = false;

      await db.saveItem(data);
    } else {
      //不为null,说明现在db已经存在,count++
      count++;
      await db.updateItem(count, goods.goodInfo.goodsId);
    }

    Provide.value<CartProvide>(context).getAllCartGoods();

//    await db.close();
    ToastUtil.showToast("添加商品至购物车成功");
  }
}
