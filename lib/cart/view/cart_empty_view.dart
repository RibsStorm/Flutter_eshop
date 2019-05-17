import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(400),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          cartImg(),
          emptyCartTips(),
          buyBuyBuy(),
        ],
      ),
    );
  }

  Widget cartImg() {
    return Stack(
      children: <Widget>[
        Container(
          //整一个圆形的灰色底,感觉这个方法不大好,
          //以后找个更好的办法来实现
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.grey.withOpacity(0.15),
                width: 50.0,
              ),
            ),
          ),
        ),
        Container(
          //这坐标我也不知道该怎么定位,我瞎调的.
          width: ScreenUtil().setWidth(350),
          height: ScreenUtil().setHeight(175),
          alignment: Alignment.center,
          child: Image.asset(
            "img/shopping_cart.png",
          ),
        ),
      ],
    );
  }

  Widget emptyCartTips() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Text(
        '购物车还空着,快起挑选商品吧!',
        style:
            TextStyle(fontSize: ScreenUtil().setSp(24.0), color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buyBuyBuy() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      child: Text(
        '随便逛逛',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(24.0),
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
