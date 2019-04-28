import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ADBanner extends StatelessWidget {
  final String adBannerImg;

  ADBanner({Key key, this.adBannerImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(adBannerImg);
  }
}
