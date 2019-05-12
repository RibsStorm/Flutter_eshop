import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderView extends StatelessWidget {
  final String leaderUrl;
  final String leaderPhone;

  LeaderView({Key key, this.leaderUrl, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _callPhone,
      child: Container(
        height: ScreenUtil().setHeight(200),
        child: Image.network(leaderUrl),
      ),
    );
  }

  void _callPhone() async {
    String url = 'tel:+ $leaderPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL Launch不能访问';
    }
  }
}
