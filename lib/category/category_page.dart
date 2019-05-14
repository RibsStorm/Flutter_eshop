import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';

import '../http/service_main.dart';
import 'model/category.dart';
import 'provide/category_provide.dart';
import 'view/category_navigation_view.dart';
import 'view/goods_show_view.dart';
import 'view/top_navigation_view.dart';
import 'model/category_goods.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: FutureBuilder(
          future: postRequest('categoryContext'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              CategoryModel listModel = CategoryModel.fromJson(data);
              //接口获取到,就默认将第一个列表传递到二级分类,防止第一次进来页面报错
              Provide.value<CategoryProvide>(context)
                  .getCategory(listModel.data.elementAt(0).bxMallSubDto);

              getCategoryGoodsList(listModel.data.elementAt(0).mallCategoryId);

              return Container(
                child: Row(
                  children: <Widget>[
                    //左侧--导航栏
                    CategoryNavigation(list: listModel.data),

                    Column(
                      children: <Widget>[
                        //右侧--顶部文字栏
                        TopNavigation(),
                        CategoryGoodsList(),
                        //右侧--商品内容展示栏
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blueAccent,
                ),
              );
            }
          }),
    );
  }

  //默认进来是第一栏,查询接口,获取默认第一栏的对应列表数据源,通过Provide传递过去
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
//
