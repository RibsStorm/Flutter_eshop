import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/mainpage_content.dart';

class RecommendShow extends StatelessWidget {
  final MainPageContent content;

  RecommendShow({Key key, this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(1925.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => showRecommendItem(index)),
    );
  }

  Widget showRecommendItem(index) {
    String floorPic;
    switch (index) {
      case 0:
        floorPic = content.floor1Pic.pICTUREADDRESS;
        break;
      case 1:
        floorPic = content.floor2Pic.pICTUREADDRESS;
        break;
      case 2:
        floorPic = content.floor3Pic.pICTUREADDRESS;
        break;
      default:
        break;
    }

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: item(floorPic),
          ),
          recommendItem(index),
        ],
      ),
    );
  }

  Widget recommendItem(index) {
    List<dynamic> floor;
    switch (index) {
      case 0:
        floor = content.floor1;
        break;
      case 1:
        floor = content.floor2;
        break;
      case 2:
        floor = content.floor3;
        break;
      default:
        break;
    }

    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(375.0),
          child: Column(
            children: <Widget>[
              item(
                floor.elementAt(0).image,
              ),
              item(
                floor.elementAt(1).image,
              ),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(375.0),
          child: Column(
            children: <Widget>[
              item(
                floor.elementAt(2).image,
              ),
              item(
                floor.elementAt(3).image,
              ),
              item(
                floor.elementAt(4).image,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget item(url) {
    return InkWell(
      onTap: () {
        //TODO...通过商品ID跳转 待添加!
      },
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }
}
