import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../model/mainpage_content.dart';

///轮播图组件
class SwiperView extends StatelessWidget {
  List<Slides> swiperList = [];

  SwiperView({Key key, this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperList.length,
        itemBuilder: (context, index) {
          return Image.network(
            "${swiperList.elementAt(index).image}",
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
