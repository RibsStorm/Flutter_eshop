import 'package:flutter/material.dart';
import 'package:flutter_eshop/routers/routers.dart';
import 'package:flutter_eshop/util/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application.dart';

class MineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(400),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: Colors.lightBlue, width: 1.0)),
      child: tipsListView(context),
    );
  }

  Widget tipsListView(BuildContext context) {
    return ListView(
      children: <Widget>[
        tips(context, '我的优惠券'),
        tips(context, '地址管理'),
        tips(context, '客服电话'),
        tips(context, '关于这玩意'),
      ],
    );
  }

  Widget tips(BuildContext context, String tip) {
    return Container(
      height: ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      ),
      child: ListTile(
        title: Text(
          tip,
          textAlign: TextAlign.center,
        ),
        onTap: () {
          if ('关于这玩意' == tip) {
            Application.router.navigateTo(context, Routers.aboutPage);
          } else {
            ToastUtil.showToast("没做,自己脑补...");
          }
        },
      ),
    );
  }
}
