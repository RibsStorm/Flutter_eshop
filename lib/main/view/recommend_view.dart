import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/mainpage_content.dart';
import '../../application.dart';

class RecommendView extends StatelessWidget {
  final List<Recommend> recommendList;

  RecommendView({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
//      margin: EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          _title(),
          _recommendList(context),
        ],
      ),
    );
  }

  ///标题
  Widget _title() {
    return Container(
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10.0),
      //底部下划线
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.lightBlueAccent),
      ),
    );
  }

  ///推荐商品
  Widget _recommend(context,index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${recommendList.elementAt(index).goodsId}');
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        height: ScreenUtil().setHeight(350),
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1.0, color: Colors.grey),
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              recommendList.elementAt(index).image,
              width: ScreenUtil().setWidth(250.0),
              height: ScreenUtil().setHeight(250.0),
            ),
            Text(
              '¥${recommendList.elementAt(index).mallPrice}',
              style: TextStyle(color: Colors.redAccent, fontSize: 12.0),
            ),
            Text(
              '¥${recommendList.elementAt(index).price}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  ///推荐商品列表
  Widget _recommendList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _recommend(context,index);
          }),
    );
  }
}
