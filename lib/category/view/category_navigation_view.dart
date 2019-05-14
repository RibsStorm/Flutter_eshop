import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../http/service_main.dart';
import 'dart:convert';

import '../model/category.dart';
import '../model/category_goods.dart';
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
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(
        color: Color.fromRGBO(236, 236, 236, 0.5),
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
        //点击后,通过provide将关联的list进行传递,传递给二级列表顶部显示
        Provide.value<CategoryProvide>(context)
            .getCategory(widget.list.elementAt(index).bxMallSubDto);
        //点击后,通过provide将关联的item进行传递,请求接口获取商品列表展示
//        Provide.value<CategoryProvide>(context).getCategoryItem(widget.list.elementAt(index).mallCategoryId);
        getCategoryGoodsList(widget.list.elementAt(index).mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
          color: isClick ? Colors.white : Colors.grey,
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

  //左边导航栏点击后,查询接口,获取对应的数据源,通过Provide传递过去
  void getCategoryGoodsList(String categoryId) async {
    await postRequest('categoryDetailList', data: {
      'categoryId': '$categoryId',
      'categorySubId': '',
      'page': '1'
    }).then((response) {
      var data = json.decode(response.toString());
      List<CategoryGoods> list = CategoryGoodsListModel.fromJson(data).data;

      Provide.value<CategoryProvide>(context).getCategoryGoodsList(list);
    });
  }
}
