import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(1334),
      child: FlareActor(
        'assets/login_screen_bg_json.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'success',
      ),
    );
  }
}
