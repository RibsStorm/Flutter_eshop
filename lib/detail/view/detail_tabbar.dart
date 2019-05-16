import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../provide/detail_provide.dart';

class DetailTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailProvide>(builder: (context, child, data) {
      return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            tab(context, '详情', data.hasSelectLeft),
            tab(context, '评论', data.hasSelectRight),
          ],
        ),
      );
    });
  }

  Widget tab(context, tabName, hasSelectLeft) {
    return Container(
      width: ScreenUtil().setWidth(375),
      height: ScreenUtil().setHeight(80),
      child: InkWell(
          onTap: () {
            Provide.value<DetailProvide>(context).setSelectZoom(tabName);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1.5,
                      color: hasSelectLeft ? Colors.blueAccent : Colors.white)),
            ),
            child: Center(
              child: Text(tabName, textAlign: TextAlign.center),
            ),
          )),
    );
  }
}
