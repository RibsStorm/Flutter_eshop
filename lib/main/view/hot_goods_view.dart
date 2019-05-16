import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/hotgoods.dart';
import '../../application.dart';

class HotGoodsList extends StatelessWidget {
  final List<HotGoods> hotgoods;
  List<Widget> goods;

  HotGoodsList({Key key, this.hotgoods});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle(),
          goodsItem(context),
        ],
      ),
    );
  }

  Widget hotTitle() {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: Text('火爆专区'),
    );
  }

  Widget goodsItem(context) {
    if (hotgoods.isNotEmpty) {
      goods = hotgoods.map((data) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/detail?id=${data.goodsId}');
          },
          child: Container(
            height: ScreenUtil().setHeight(360),
            width: ScreenUtil().setWidth(365),
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  data.image,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(26),
                        color: Colors.redAccent.shade100),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '¥${data.mallPrice}',
                        style: TextStyle(fontSize: 11.0),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(180),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '¥${data.price}',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      //返回一个遍历火爆专区商品构成的流式布局
      return Wrap(
        spacing: 2,
        children: goods,
      );
    } else {
      return Text('');
    }
  }
}
