import 'package:flutter/material.dart';
import 'package:flutter_eshop/util/ToastUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: tipsListView(),
    );
  }

  Widget tipsListView() {
    return ListView(
      children: <Widget>[
        tips('我的优惠券'),
        tips('地址管理'),
        tips('客服电话'),
        tips('关于商城'),
      ],
    );
  }

  Widget tips(String tip) {
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
          ToastUtil.showToast("没做,自己脑补...");
        },
      ),
    );
  }
}
