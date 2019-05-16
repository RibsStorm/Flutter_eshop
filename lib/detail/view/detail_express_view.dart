import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExpress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(60),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6.0, bottom: 6.0),
      child: express('急速送达,正品保证'),
    );
  }

  Widget express(expressDetail) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Text(
        '说明: $expressDetail',
        style: TextStyle(
            color: Colors.blueAccent, fontSize: ScreenUtil().setSp(28.0)),
      ),
    );
  }
}
