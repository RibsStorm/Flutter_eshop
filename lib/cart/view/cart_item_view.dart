import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_eshop/cart/view/cart_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../util/ToastUtil.dart';
import '../provide/cart_provide.dart';
import 'cart_bottom_view.dart';
import 'cart_count_view.dart';

class CartListView extends StatefulWidget {
  List<CartGoods> list;

  @override
  _CartListViewState createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  int count = 0;
  double money = 0.00;

  @override
  Widget build(BuildContext context) {
    count = Provide.value<CartProvide>(context).count;
    money = Provide.value<CartProvide>(context).money;
    return Provide<CartProvide>(builder: (context, child, data) {
      if (data.goods.isNotEmpty) {
        widget.list = data.goods;
        return Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(1334),
          child: Stack(
            children: <Widget>[
              cartGoodsList(),
              Positioned(bottom: 0.0, left: 0.0, child: CartBottomView()),
            ],
          ),
        );
      } else {
        return Center(
          child: EmptyCartView(),
        );
      }
    });
  }

  Widget cartGoodsList() {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(100)),
      child: ListView.builder(
          itemCount: widget.list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              cartItemView(widget.list.elementAt(index))),
    );
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
        value: item.isSelect,
        onChanged: (bool isCheck) {
          //每次点击后,刷新页面,对选择商品数量和结算的金额进行计算.
          setState(() {
            item.isSelect = isCheck;
            if (isCheck) {
              count += item.count;
              money += (item.price * item.count);
            } else {
              count = (count - item.count) <= 0 ? 0 : count - item.count;
              money = (money - item.price * item.count) <= 0.00
                  ? 0.00
                  : (money - item.price * item.count);
            }
            Provide.value<CartProvide>(context).refreshPayMoney(count, money);
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              item.goodsName,
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: CartCountView(item: item),
          ),
        ],
      ),
    );
  }

//商品价格 & 删除按钮
  Widget goodsPrice(CartGoods item) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      height: ScreenUtil().setHeight(120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "¥ ${item.price}",
            style: TextStyle(fontSize: 12.0),
            textAlign: TextAlign.right,
          ),
          Text(
            "¥ ${item.oldPrice}",
            style: TextStyle(fontSize: 8.0, color: Colors.grey),
            textAlign: TextAlign.right,
          ),
          InkWell(
            onTap: () {
              //如果商品是选中的,点击删除,删除其对应的 统计商品数量和价格,刷新Provide
              if (item.isSelect) {
                count = (count - item.count) <= 0 ? 0 : count - item.count;
                money = (money - item.price * item.count) <= 0.00
                    ? 0.00
                    : (money - item.price * item.count);
                Provide.value<CartProvide>(context)
                    .refreshPayMoney(count, money);
              }
              deleteAndRefresh(item);
            },
            child: Icon(CupertinoIcons.delete_simple),
          ),
        ],
      ),
    );
  }

//删除当前商品,并刷新SP内保存的购物车商品
  deleteAndRefresh(CartGoods item) async {
    widget.list.remove(item);
    Provide.value<CartProvide>(context).refreshCartGoods(item);
    ToastUtil.showToast("删除购物车物品成功");
  }
}
