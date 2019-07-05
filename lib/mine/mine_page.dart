import 'package:flutter/material.dart';

import 'view/mine_user_info.dart';
import 'view/mine_tip_list.dart';
import 'view/mine_order.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: MineView(),
    );
  }

  Widget MineView() {
    return Container(
      child: ListView(
        children: <Widget>[
          MineUserInfo(),
          MineOrder(),
          MineList(),
        ],
      ),
    );
  }
}
