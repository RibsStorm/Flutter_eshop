import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';

import '../http/service_main.dart';
import 'model/category.dart';
import 'view/category_navigation_view.dart';

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

              return Container(
                child: Row(
                  children: <Widget>[
                    CategoryNavigation(list: listModel.data),
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
}
//
