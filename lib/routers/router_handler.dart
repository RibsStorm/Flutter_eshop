import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_eshop/detail/goods_detail_view.dart';

Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodId = params['id'].first;
  return DetailPage(goodId: goodId);
});
