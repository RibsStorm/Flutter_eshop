import 'package:flutter/material.dart';

class LeaderView extends StatelessWidget {
  final String leaderUrl;
  final String leaderPhone;
  final String leaderName;

  LeaderView({Key key, this.leaderUrl, this.leaderPhone, this.leaderName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(),
    );
  }
}
