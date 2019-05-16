import 'dart:convert';

import 'package:flutter/material.dart';

import '../../http/service_main.dart';
import '../model/goods.dart';

class DetailProvide with ChangeNotifier {
  String goodsName = "商品详情";
  Goods goods;
  bool hasSelectLeft = true;
  bool hasSelectRight = false;

  getGoodsInfo(String goodsId) async {
    await postRequest('getGoodDetailById', data: {'goodId': goodsId})
        .then((result) {
      var data = json.decode(result.toString());
      goods = GoodsModel.fromJson(data).data;
      goodsName = goods.goodInfo.goodsName;
      notifyListeners();
    });
  }

  setSelectZoom(String tabName) {
    hasSelectLeft = '详情' == tabName;
    hasSelectRight = '评论' == tabName;
    notifyListeners();
  }
}
