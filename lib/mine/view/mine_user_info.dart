import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(400),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          userInfoBG(),
          userInfoView(),
        ],
      ),
    );
  }

  Widget userInfoBG() {
    return ClipPath(
      clipper: BezierView(),
      child: Container(
        color: Colors.lightBlueAccent,
      ),
    );
  }

  Widget userInfoView() {
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setHeight(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        border: Border.all(width: 1.0, color: Colors.lightBlue),
        image: DecorationImage(
          image: Image.asset('img/img_mine_bg.jpg').image,
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: <Widget>[
          userImg(),
          userInfoText(),
        ],
      ),
    );
  }

  Widget userImg() {
    return Padding(
      padding: EdgeInsets.only(left: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          'img/icon_user.jpg',
          width: 120,
          height: 120,
        ),
      ),
    );
  }

  Widget userInfoText() {
    return Container(
      height: ScreenUtil().setHeight(200),
      width: ScreenUtil().setWidth(400),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("金牌会员"),
          ),
          ListTile(
            title: Text("名字叫做 再来一瓶"),
          ),
        ],
      ),
    );
  }
}

class BezierView extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, ScreenUtil().setHeight(80));
    var firstControlPoint =
        Offset(ScreenUtil().setWidth(375), ScreenUtil().setHeight(150));
    var firstEndPoint =
        Offset(ScreenUtil().setWidth(750), ScreenUtil().setHeight(80));

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(ScreenUtil().setWidth(750), ScreenUtil().setHeight(80));
    path.lineTo(ScreenUtil().setWidth(750), 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
