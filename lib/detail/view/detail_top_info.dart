import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/detail_provide.dart';

class GoodsTopDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailProvide>(builder: (context, child, data) {
      if (data.goods != null) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              goodsPic(data.goods.goodInfo.image1),
              goodsName(data.goods.goodInfo.goodsName),
              goodsNo(data.goods.goodInfo.goodsSerialNumber),
              goodsPrice(data.goods.goodInfo.presentPrice,
                  data.goods.goodInfo.oriPrice),
            ],
          ),
        );
      }
    });
  }

  Widget goodsPic(imageUrl) {
    return Image.network(
      imageUrl,
      height: ScreenUtil().setHeight(650),
      width: ScreenUtil().setWidth(750),
    );
  }

  Widget goodsName(goodsName) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '$goodsName',
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget goodsNo(goodsNumber) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
      alignment: Alignment.centerLeft,
      child: Text(
        "编号:$goodsNumber",
        style:
            TextStyle(fontSize: ScreenUtil().setSp(24.0), color: Colors.grey),
      ),
    );
  }

  Widget goodsPrice(nowPrice, oldPrice) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 4.0),
          child: Text(
            "¥ $nowPrice",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(48.0),
                color: Colors.blueAccent),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(32.0, 4.0, 0.0, 4.0),
          child: Text(
            "市场价: $oldPrice",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32.0), color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
