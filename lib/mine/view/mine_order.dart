import 'package:flutter/material.dart';
import 'package:flutter_eshop/util/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(220),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: Colors.lightBlue, width: 1.0)),
      child: orderView(),
    );
  }

  Widget orderView() {
    return Column(
      children: <Widget>[
        orderTile(),
        Expanded(
          child: orderStatus(),
        ),
      ],
    );
  }

  Widget orderTile() {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: ListTile(
        title: Text(
          "我的订单",
          textAlign: TextAlign.center,
        ),
        onTap: () {
          ToastUtil.showToast("没做,自己脑补...");
        },
      ),
    );
  }

  Widget orderStatus() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          orderStatusView('img/icon_order_2.png', '代付款'),
          orderStatusView('img/icon_order_1.png', '代发货'),
          orderStatusView('img/icon_order_3.png', '代收货'),
          orderStatusView('img/icon_order_4.png', '代评价'),
        ],
      ),
    );
  }

  Widget orderStatusView(String img, String str) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            img,
            width: 38,
            height: 38,
          ),
          Text(str),
        ],
      ),
      onTap: () {
        ToastUtil.showToast("没做,自己脑补...");
      },
    );
  }
}
