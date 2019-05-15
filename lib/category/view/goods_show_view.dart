import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../model/category_goods.dart';
import '../provide/category_provide.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(builder: (context, child, list) {
      //通过provide接受传递过来的需要显示的数据源
      if (list.goodsList.isNotEmpty) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(550),
            child: GridView.count(
              crossAxisCount: 2,
              //子widget的 宽高比
              childAspectRatio: 0.70,
              padding: EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 6.0),
              children: list.goodsList.map((data) {
                return GoodsView(data);
              }).toList(),
            ),
          ),
        );
      }
    });
  }

  Widget GoodsView(CategoryGoods data) {
    return InkWell(
      onTap: () {
        //TODO...通过商品ID跳转 待添加!
      },
      child: Container(child: goodsItem(data)),
    );
  }

  Widget goodsItem(CategoryGoods data) {
    return Column(
      children: <Widget>[
        Image.network(
          data.image,
          width: ScreenUtil().setWidth(220),
          height: ScreenUtil().setHeight(220),
        ),
        Text(
          data.goodsName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(26),
              color: Colors.redAccent.shade100),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '¥${data.presentPrice}',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(130),
              child: Text(
                '¥${data.oriPrice}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
