import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';

import 'provide/detail_provide.dart';
import 'view/detail_express_view.dart';
import 'view/detail_html_view.dart';
import 'view/detail_tabbar.dart';
import 'view/detail_toolbar.dart';
import 'view/detail_top_info.dart';

class DetailPage extends StatelessWidget {
  final String goodId;

  DetailPage({Key key, this.goodId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "商品详情",
          style: TextStyle(fontSize: ScreenUtil().setSp(48.0)),
        ),
      ),
      body: FutureBuilder(
          future: getGoodsInfo(context),
          builder: (context, snapshot) {
            //通过网路请求,请求完成后加载
            if (snapshot.hasData) {
              //为了底部的工具条,使用Stack层叠布局
              return Stack(
                children: <Widget>[
                  //默认摆放,不需要外面包裹Positioned
                  detailView(),
                  //底部工具栏,需要指定位置摆放,指定位置
                  Positioned(bottom: 0.0, left: 0.0, child: DetailToolBar()),
                ],
              );
            } else {
              return Container(
                child: SpinKitDoubleBounce(
                  color: Colors.blueAccent,
                  size: 80.0,
                ),
              );
            }
          }),
    );
  }

  Widget detailView() {
    return Container(
      child: ListView(
        children: <Widget>[
          GoodsTopDetail(),
          DetailExpress(),
          DetailTabbar(),
          DetailHTML(),
        ],
      ),
    );
  }

  Future getGoodsInfo(context) async {
    await Provide.value<DetailProvide>(context).getGoodsInfo(goodId);
    return '加载完成!!!';
  }
}
