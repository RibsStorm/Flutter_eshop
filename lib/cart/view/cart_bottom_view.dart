import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../model/cart_goods.dart';
import '../provide/cart_provide.dart';

class CartBottomView extends StatefulWidget {
  @override
  _CartBottomViewState createState() => _CartBottomViewState();
}

class _CartBottomViewState extends State<CartBottomView> {
  bool isAllSelect = false;
  int count = 0;
  double money = 0.00;

  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
      builder: (context, child, data) {
        count = data.count;
        money = data.money;
        return Container(
          height: ScreenUtil().setHeight(100),
          width: ScreenUtil().setWidth(750),
          child: Row(
            children: <Widget>[
              selectAll(context),
              Text("全选"),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    showMoney(),
                    showTips(),
                  ],
                ),
              ),
              payMoney()
            ],
          ),
        );
      },
    );
  }

  Widget selectAll(BuildContext context) {
    return Container(
      child: Checkbox(
          value: isAllSelect,
          onChanged: (bool isCheck) {
            setState(() {
              isAllSelect = isCheck;
            });

            //获取当前购物车页面的所有数据,根据 全选checkbox状态,对所有物品的状态进行调整.
            List<CartGoods> cartList =
                Provide.value<CartProvide>(context).goods;
            cartList.forEach((cart) {
              countMoney(cart, isCheck);
              cart.isSelect = isCheck;
            });
            Provide.value<CartProvide>(context).refreshAllCartGoods(cartList);
            Provide.value<CartProvide>(context).refreshCartInfo(count, money);
          }),
    );
  }

  Widget showMoney() {
    return Column(
      children: <Widget>[
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: "合计 : ",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: "¥ ",
                  style: TextStyle(
                    color: Colors.red,
                  )),
              TextSpan(
                  //对数据进行处理,最多保留2位小数点,防止出现一串9999999999999999或者00000000001的BUG
                  text: money.toStringAsFixed(2),
                  style: TextStyle(color: Colors.red, fontSize: 18.0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget showTips() {
    return Text(
      '满10元免配送费,预购免配送费',
      style: TextStyle(fontSize: 10.0),
    );
  }

  Widget payMoney() {
    return FlatButton(
        onPressed: () {
          //TODO...跳转到支付页面
        },
        child: Container(
          decoration: BoxDecoration(
            color: count == 0 ? Colors.grey : Colors.redAccent,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              count == 0 ? "结算" : "结算($count)",
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  countMoney(CartGoods item, bool hasSelect) {
    setState(() {
      if (hasSelect && !item.isSelect) {
        //全选,原有商品没有选中,count++,money++
        count += item.count;
        money += (item.price * item.count);
      } else if (!hasSelect && item.isSelect) {
        //反选,,原有商品选中,count--,money--
        count = (count - item.count) <= 0 ? 0 : count - item.count;
        money = (money - item.price * item.count) <= 0.00
            ? 0.00
            : (money - item.price * item.count);
      }
      print("全选后的: ====价格是$money====商品总量是$count");
    });
  }
}
