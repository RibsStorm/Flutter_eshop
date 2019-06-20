import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../db/DatabaseHelper.dart';
import '../../util/ToastUtil.dart';
import '../provide/cart_provide.dart';
import 'cart_bottom_view.dart';

class CartListView extends StatefulWidget {
  final List<CartGoods> list;

  CartListView({Key key, @required this.list}) : super(key: key);

  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  int count = 0;
  double money = 0.00;
  bool hasSelect = false;

  @override
  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Column(
//        children: <Widget>[
//          Container(
//            width: ScreenUtil().setWidth(750),
//            height: ScreenUtil().setHeight(910),
//            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
//            child: cartGoodsList(),
//          ),
//          CartBottomView(),
//        ],
//      ),
//    );
    return Stack(
      children: <Widget>[
        cartGoodsList(),
        Positioned(bottom: 0.0, left: 0.0, child: CartBottomView()),
      ],
    );
  }

  Widget cartGoodsList() {
    return ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            cartItemView(widget.list.elementAt(index)));
  }

//购物车商品详情
  Widget cartItemView(CartGoods item) {
    print("购物车侧信息是:$item");
    return Container(
      height: ScreenUtil().setHeight(140),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Row(
        children: <Widget>[
          goodsSelect(item),
          goodsImage(item),
          goodsTipAndCount(item),
          goodsPrice(item),
        ],
      ),
    );
  }

//单个商品checkBox
  Widget goodsSelect(CartGoods item) {
    return Checkbox(
        value: hasSelect,
        onChanged: (bool isCheck) {
          //每次点击后,刷新页面,对选择商品数量和结算的金额进行计算.
          setState(() {
            hasSelect = isCheck;
            if (isCheck) {
              Provide.value<CartProvide>(context).refreshPayMoney(
                  count + item.count, money + item.price * item.count);
            } else {
              int tempCount =
                  (count - item.count) <= 0 ? 0 : count - item.count;
              double tempMoney = (money - item.price * item.count) <= 0.00
                  ? 0.00
                  : (money - item.price * item.count);
              Provide.value<CartProvide>(context)
                  .refreshPayMoney(tempCount, tempMoney);
            }
          });
        });
  }

  Widget goodsImage(CartGoods item) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
      margin: EdgeInsets.all(4.0),
      child: Image.network(
        item.images,
        width: ScreenUtil().setWidth(120),
        height: ScreenUtil().setHeight(120),
      ),
    );
  }

  Widget goodsTipAndCount(CartGoods item) {
    return Expanded(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            item.goodsName,
            maxLines: 2,
          ),
        ),
        //TODO...差一个 商品数量加减的那个
      ],
    ));
  }

//商品价格 & 删除按钮
  Widget goodsPrice(CartGoods item) {
    return Container(
      height: ScreenUtil().setHeight(120),
      child: Column(
        children: <Widget>[
          Text(
            "¥ ${item.price}",
            style: TextStyle(fontSize: 12.0),
          ),
          Text(
            "¥ ${item.oldPrice}",
            style: TextStyle(fontSize: 10.0, color: Colors.grey),
          ),
          IconButton(
              alignment: Alignment.topCenter,
              icon: Icon(CupertinoIcons.delete_simple),
              padding: EdgeInsets.only(bottom: 1.0),
              onPressed: () {
                setState(() {
                  //如果商品是选中的,点击删除,删除其对应的 统计商品数量和价格,刷新Provide
                  if (hasSelect) {
                    int tempCount =
                        (count - item.count) <= 0 ? 0 : count - item.count;
                    double tempMoney = (money - item.price * item.count) <= 0.00
                        ? 0.00
                        : money - item.price * item.count;
                    Provide.value<CartProvide>(context)
                        .refreshPayMoney(tempCount, tempMoney);
                  }

                  deleteAndRefresh(item);
                });
              }),
        ],
      ),
    );
  }

//删除当前商品,并刷新SP内保存的购物车商品
  deleteAndRefresh(CartGoods item) async {
    widget.list.remove(item);
    var db = DatabaseHelper();
    await db.deleteItem(item.goodsId);
//    await db.close();
    ToastUtil.showToast("删除购物车物品成功");
  }
}
