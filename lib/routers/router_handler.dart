import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/cart/cart_page.dart';
import 'package:flutter_eshop/category/category_page.dart';
import 'package:flutter_eshop/detail/goods_detail_view.dart';

//商品详情
Handler detailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodId = params['id'].first;
  return DetailPage(goodId: goodId);
});

//商品分类
Handler cartgoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CategoryPage();
});

//购物车列表
Handler cartHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartPage();
});
