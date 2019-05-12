import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/category_provide.dart';

class TopNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //最外层需要Provide包裹,传递3个参数,第3个参数为 with ChangeNotifier的类
    return Provide<CategoryProvide>(builder: (context, child, list) {
      return Container(
        width: ScreenUtil().setWidth(530),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.items.length,
            itemBuilder: (context, index) =>
                goodsNavigation(list.items.elementAt(index).mallSubName)),
      );
    });
  }

  Widget goodsNavigation(name) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12.0, right: 6.0),
      child: Text(name),
    );
  }
}
