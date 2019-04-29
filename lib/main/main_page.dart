import 'dart:convert';

import 'package:flutter/material.dart';

import '../http/service_main.dart';
import 'view/ad_banner_view.dart';
import 'view/category_list.dart';
import 'view/leader_view.dart';
import 'view/swiper_view.dart';
import 'view/recommend_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是首页'),
      ),
      body: FutureBuilder(

          ///future传入对应的耗时请求即可.
          future: getMainPageContent(),
          builder: (context, snapshot) {
            ///hasData用于判断当前返回response是否有值
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString())['data'];
              List<Map> swiper = (data['slides'] as List).cast();
              List<Map> categoryList = (data['category'] as List).cast();
              String adImg = data['advertesPicture']['PICTURE_ADDRESS'];
              String leaderUrl = data['shopInfo']['leaderImage'];
              String leaderPhone = data['shopInfo']['leaderPhone'];
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
                    LeaderView(leaderUrl: leaderUrl, leaderPhone: leaderPhone,),

                    ///5.商品推荐
                    RecommendView(recommendList: recommendList),
                    ///6.楼层区域

                    ///7.火爆专区

                  ],
                ),
              );
            } else {
              return Center(
                child: Text("23333"),
              );
            }
          }),
    );
  }
}
