import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provide/provide.dart';

import '../provide/detail_provide.dart';

class DetailHTML extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailProvide>(builder: (context, child, data) {
      if (data.hasSelectLeft) {
        return Html(data: data.goods.goodInfo.goodsDetail);
      } else {
        return Container(
          child: Text("这是评论区,没做,自行脑补~~~"),
        );
      }
    });
  }
}
