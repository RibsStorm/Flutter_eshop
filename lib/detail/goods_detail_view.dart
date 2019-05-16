import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provide/provide.dart';

import 'provide/detail_provide.dart';
import 'view/detail_top_info.dart';
import 'view/detail_express_view.dart';
import 'view/detail_tabbar.dart';
import 'view/detail_html_view.dart';

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
            if (snapshot.hasData) {
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

  Future getGoodsInfo(context) async {
    await Provide.value<DetailProvide>(context).getGoodsInfo(goodId);
    return '加载完成!!!';
  }
}
