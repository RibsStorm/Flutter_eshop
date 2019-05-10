import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/category.dart';

class CategoryNavigation extends StatefulWidget {
  final List<Category> list;

  CategoryNavigation({Key key, this.list});

  @override
  _CategoryNavigationState createState() => _CategoryNavigationState();
}

class _CategoryNavigationState extends State<CategoryNavigation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(220),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) => navigationItem(index)),
    );
  }

  Widget navigationItem(index) {
    return InkWell(
      onTap: () {
        //TODO...通过商品ID跳转 待添加!
      },
      child: Container(
        height: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            '${widget.list[index].mallCategoryName}',
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          ),
        ),
      ),
    );
  }
}
