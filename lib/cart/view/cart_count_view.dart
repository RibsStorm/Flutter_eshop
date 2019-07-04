import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/model/cart_goods.dart';
import 'package:flutter_eshop/db/DatabaseHelper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/cart_provide.dart';

class CartCountView extends StatelessWidget {
  CartGoods item;
  int count;
  double money;

  CartCountView({Key key, this.item});

  @override
  Widget build(BuildContext context) {
    count = Provide.value<CartProvide>(context).count;
    money = Provide.value<CartProvide>(context).money;
    return Container(
      child: Row(
        children: <Widget>[
          minusBtn(context),
          countView(),
          plusBtn(context),
        ],
      ),
    );
  }

  Widget minusBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        //减号
        if (item.count > 1) {
          item.count--;

          if (item.isSelect) {
            count--;
            money = (money - item.price) <= 0.00 ? 0.00 : (money - item.price);
          }
          Provide.value<CartProvide>(context).refreshPayMoney(count, money);
          notifyItemCount();
        }
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.grey),
        ),
        child: Text('-'),
      ),
    );
  }

  Widget plusBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        //加号
        item.count++;
        if (item.isSelect) {
          count++;
          money = money + item.price;
        }
        Provide.value<CartProvide>(context).refreshPayMoney(count, money);
        notifyItemCount();
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.grey),
        ),
        child: Text('+'),
      ),
    );
  }

  Widget countView() {
    return Container(
      width: ScreenUtil().setWidth(75),
      height: ScreenUtil().setHeight(45),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
              top: BorderSide(width: 1.0, color: Colors.grey))),
      alignment: Alignment.center,
      child: Text('${item.count}'),
    );
  }

  notifyItemCount() async {
    var db = DatabaseHelper();
    await db.updateItem(item.count, item.goodsId);
  }
}
