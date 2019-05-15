import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../http/service_main.dart';
import '../model/category_goods.dart';
import '../provide/category_provide.dart';

class TopNavigation extends StatefulWidget {
  @override
  _TopNavigationState createState() => _TopNavigationState();
}

class _TopNavigationState extends State<TopNavigation> {
  int lastChildIndex = 0;
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    //最外层需要Provide包裹,传递3个参数,第3个参数为 with ChangeNotifier的类
    return Provide<CategoryProvide>(builder: (context, child, list) {
      return Container(
        width: ScreenUtil().setWidth(550),
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.items.length,
          itemBuilder: (context, index) => goodsNavigation(
              list.childIndex,
              index,
              list.items.elementAt(index).mallSubName,
              list.items.elementAt(index).mallCategoryId,
              list.items.elementAt(index).mallSubId),
        ),
      );
    });
  }

  Widget goodsNavigation(
      childIndex, currentIndex, name, categoryId, categorySubId) {
    //初始创建,每次点击 新的一级列表,重置点击位置,回归到0
    if (lastChildIndex != childIndex) {
      lastChildIndex = childIndex;
      selectIndex = 0;
    }

    return InkWell(
      onTap: () {
        setState(() {
          //在一个一级列表内,每次点击,获取点击的位置,刷新UI
          selectIndex = currentIndex;
        });

        getCategoryGoodsList(categoryId, categorySubId);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.0, right: 4.0),
        child: Card(
          color: selectIndex == currentIndex
              ? Colors.redAccent
              : Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(name),
          ),
        ),
      ),
    );
  }

  //顶部二级列表点击后,获取对应的subId,请求接口获取展示商品区的商品列表
  void getCategoryGoodsList(String categoryId, String categorySubId) async {
    await postRequest('categoryDetailList', data: {
      'categoryId': '$categoryId',
      'categorySubId': '$categorySubId',
      'page': '1',
    }).then((response) {
      var data = json.decode(response.toString());
      List<CategoryGoods> list = CategoryGoodsListModel.fromJson(data).data;

      if (list != null && list.isNotEmpty) {
        Provide.value<CategoryProvide>(context).getCategoryGoodsList(list);
      } else {
        //没有获取到对应的分类商品数据,进行Toast提示.
        Fluttertoast.showToast(
            msg: "~~~木有数据~~~",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightBlueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
