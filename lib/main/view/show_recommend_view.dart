import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application.dart';
import '../model/mainpage_content.dart';

class RecommendShow extends StatelessWidget {
  final MainPageContent content;
  String goodsId;

  RecommendShow({Key key, this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(1925.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => showRecommendItem(context, index)),
    );
  }

  Widget showRecommendItem(context, index) {
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
            child: item(context, floorPic, ''),
          ),
          recommendItem(context, index),
        ],
      ),
    );
  }

  Widget recommendItem(context, index) {
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
              item(context, floor.elementAt(0).image,
                  floor.elementAt(0).goodsId),
              item(
                context,
                floor.elementAt(1).image,
                floor.elementAt(1).goodsId,
              ),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(375.0),
          child: Column(
            children: <Widget>[
              item(
                context,
                floor.elementAt(2).image,
                floor.elementAt(2).goodsId,
              ),
              item(
                context,
                floor.elementAt(3).image,
                floor.elementAt(3).goodsId,
              ),
              item(
                context,
                floor.elementAt(4).image,
                floor.elementAt(4).goodsId,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget item(context, url, goodsId) {
    return InkWell(
      onTap: () {
        if (goodsId != null && goodsId != '') {
          Application.router.navigateTo(context, '/detail?id=$goodsId');
        }
      },
      child: Image.network(
        url,
        fit: BoxFit.fill,
      ),
    );
  }
}
