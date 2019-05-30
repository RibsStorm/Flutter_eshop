import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/cart_provide.dart';

class CartBottomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
      builder: (context, child, data) {
        return Row(
          children: <Widget>[
            selectAll(),
            Text("全选"),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  showMoney(data.money),
                  showTips(),
                ],
              ),
            ),
            payMoney(data.count)
          ],
        );
      },
    );
  }

  Widget selectAll() {
    return Container(
      child: Checkbox(value: false, onChanged: (bool isCheck) {}),
    );
  }

  Widget showMoney(double money) {
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: "合计 : ",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: "¥ ", style: TextStyle(color: Colors.red)),
              TextSpan(
                  text: "$money",
                  style: TextStyle(color: Colors.red, fontSize: 18.0))
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

  Widget payMoney(int count) {
    return FlatButton(
        onPressed: () {
          //TODO...跳转到支付页面
        },
        child: Container(
          decoration: BoxDecoration(
            color: count == 0 ? Colors.grey : Colors.redAccent,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              count == 0 ? "结算" : "结算$count",
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
