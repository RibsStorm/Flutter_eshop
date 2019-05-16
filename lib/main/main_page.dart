import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../http/service_main.dart';
import 'model/hotgoods.dart';
import 'model/mainpage_content.dart';
import 'view/ad_banner_view.dart';
import 'view/category_list.dart';
import 'view/hot_goods_view.dart';
import 'view/leader_view.dart';
import 'view/recommend_view.dart';
import 'view/show_recommend_view.dart';
import 'view/swiper_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 1;
  List<HotGoods> hotGoods = [];

  GlobalKey<RefreshFooterState> footerState = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('这是首页'),
      ),
      body: FutureBuilder(
          //future传入对应的耗时请求即可.
          future: postRequest('homePageContext',
              data: {'lon': '115.02932', 'lat': '35.76189'}),
          builder: (context, snapshot) {
            //hasData用于判断当前返回response是否有值
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              MainPageContent content =
                  MainPageContentModel.fromJson(data).data;

              return EasyRefresh(
                //自定义底部加载栏
                refreshFooter: ClassicsFooter(
                  key: footerState,
                  bgColor: Colors.white,
                  textColor: Colors.blueAccent,
                  moreInfoColor: Colors.blueAccent,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '...加载中...',
                  loadReadyText: '上拉即可加载',
                ),

                //上拉加载更多逻辑
                loadMore: () async {
                  await postRequest('hotGoodsList', data: {'page': pageIndex})
                      .then((result) {
                    var data = json.decode(result);
                    List<HotGoods> goods = HotGoodsModel.fromJson(data).data;
                    setState(() {
                      hotGoods.addAll(goods);
                      pageIndex++;
                    });
                  });
                },

                child: ListView(
                  children: <Widget>[
                    ///1.轮播图
                    SwiperView(swiperList: content.slides),

                    ///2.gridview 商品列表
                    MainCategoryList(categoryList: content.category),

                    ///3.小的宣传栏
                    ADBanner(
                        adBannerImg: content.advertesPicture.pICTUREADDRESS),

                    ///4.店长电话
                    LeaderView(
                      leaderUrl: content.shopInfo.leaderImage,
                      leaderPhone: content.shopInfo.leaderPhone,
                    ),

                    ///5.商品推荐
                    RecommendView(recommendList: content.recommend),

                    ///6.楼层区域
                    RecommendShow(content: content),

                    ///7.火爆专区
                    HotGoodsList(hotgoods: hotGoods),
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
