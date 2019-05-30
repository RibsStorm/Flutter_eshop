import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          save(context);
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

  /// 实际开发肯定是将购物车的信息保存在服务器,再不济也保存在数据库,这保存在SP有点low
  ///
  ///创建一个 异步查询购物车信息和保存的方法
  ///保存使用 cartInfo : XXXX 格式保存.
  ///每次点击 添加到购物车时,将SP内的数据取出,decode后遍历是否存在相同商品
  ///存在即count++,不存在将商品转换成cartGoods,添加到集合,再转车string,保存回SP.
  ///购物车内,通过SP获取列表进行布局UI展示.
  save(BuildContext context) async {
    //获取当前页面的信息
    Goods goods = Provide.value<DetailProvide>(context).goods;
    SharedPreferences sp = await SharedPreferences.getInstance();
    //拿取保存在SP的信息
    String cartInfo = sp.getString('cartInfo');
    var temp = cartInfo == null ? [] : json.decode(cartInfo.toString());
    List<Map> cartGoods = (temp as List).cast();

    if (cartGoods.isEmpty) {
      //购物车集合为空,直接添加
      cartGoods.add({
        'goodId': goods.goodInfo.goodsId,
        'goodsName': goods.goodInfo.goodsName,
        'count': 1,
        'price': goods.goodInfo.presentPrice,
        'images': goods.goodInfo.image1
      });
    } else {
      dynamic addGoods;
      cartGoods.forEach((data) {
        //通过goodsId来判断
        if (data['goodsId'] == goods.goodInfo.goodsId) {
          data['count'] = data['count'] + 1;
        } else {
          addGoods = {
            'goodId': goods.goodInfo.goodsId,
            'goodsName': goods.goodInfo.goodsName,
            'count': 1,
            'price': goods.goodInfo.presentPrice,
            'images': goods.goodInfo.image1
          };
        }
      });

      if (addGoods != null) {
        //避免在遍历里面添加,导致 并发修改异常,其实可以试试用 iterator?
        cartGoods.add(addGoods);
        addGoods = null;
      }
      //最后将这个list再抓换成json保存回sp内.
      String cartStr = json.encode(cartGoods).toString();
      print("购物车内的信息:$cartStr");
      sp.setString('cartInfo', cartStr);
    }
  }
}
