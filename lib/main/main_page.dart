import 'dart:convert';

import 'package:flutter/material.dart';

import '../http/service_main.dart';
import 'view/ad_banner_view.dart';
import 'view/category_list.dart';
import 'view/leader_view.dart';
import 'view/recommend_view.dart';
import 'view/show_recommend_view.dart';
import 'view/swiper_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是首页'),
      ),
      body: FutureBuilder(

          ///future传入对应的耗时请求即可.
          future: postRequest('homePageContext', {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            ///hasData用于判断当前返回response是否有值
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString())['data'];
              //轮播图数据源
              List<Map> swiper = (data['slides'] as List).cast();
              //gridview 商品列表数据源
              List<Map> categoryList = (data['category'] as List).cast();
              //tips条数据源
              String adImg = data['advertesPicture']['PICTURE_ADDRESS'];
              //店长部分数据源
              String leaderUrl = data['shopInfo']['leaderImage'];
              String leaderPhone = data['shopInfo']['leaderPhone'];
              //商品推荐数据源
              List<Map> recommendList = (data['recommend'] as List).cast();

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ///1.轮播图
                    SwiperView(swiperList: swiper),

                    ///2.gridview 商品列表
                    MainCategoryLit(categoryList: categoryList),

                    ///3.小的宣传栏
                    ADBanner(adBannerImg: adImg),

                    ///4.店长电话
                    LeaderView(
                      leaderUrl: leaderUrl,
                      leaderPhone: leaderPhone,
                    ),

                    ///5.商品推荐
                    RecommendView(recommendList: recommendList),

                    ///6.楼层区域
                    RecommendShow(data: data),

                    ///7.火爆专区
                    HotGoods(),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("接口请求异常,请重试"),
              );
            }
          }),
    );
  }
}

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    postRequest('hotGoodsList', 1).then((data) {
      print(data.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
