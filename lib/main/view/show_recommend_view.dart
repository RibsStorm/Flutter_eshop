import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendShow extends StatelessWidget {
  var data;

  RecommendShow({Key key, this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(2535.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => showRecommendItem(index)),
    );
  }

  Widget showRecommendItem(index) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            child: item(data['floor${index + 1}Pic']['PICTURE_ADDRESS']),
          ),
          recommendItem(index),
        ],
      ),
    );
  }

  Widget recommendItem(index) {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(375.0),
          child: Column(
            children: <Widget>[
              item(
                data['floor${index + 1}'][0]['image'],
              ),
              item(
                data['floor${index + 1}'][1]['image'],
              ),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(375.0),
          child: Column(
            children: <Widget>[
              item(
                data['floor${index + 1}'][2]['image'],
              ),
              item(
                data['floor${index + 1}'][3]['image'],
              ),
              item(
                data['floor${index + 1}'][4]['image'],
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
