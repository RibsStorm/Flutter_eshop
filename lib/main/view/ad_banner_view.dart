import 'package:flutter/material.dart';

class ADBanner extends StatelessWidget {
  final String adBannerImg;

  ADBanner({Key key, this.adBannerImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(adBannerImg);
  }
}
