import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../model/category.dart';
import '../provide/category_provide.dart';

class CategoryNavigation extends StatefulWidget {
  final List<Category> list;
  int currentIndex = 0;

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
    bool isClick = (index == widget.currentIndex);
    return InkWell(
      onTap: () {
        //针对每次点击,重新传递index,根据click状态,对背景进行修改
        setState(() {
          widget.currentIndex = index;
        });
        //点击后,通过provide将关联的list进行传递
        Provide.value<CategoryProvide>(context)
            .getCategory(widget.list.elementAt(index).bxMallSubDto);
      },
      child: Container(
        height: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
          color: isClick ? Colors.grey : Colors.white,
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
