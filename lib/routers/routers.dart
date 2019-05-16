import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers{
  static String root = "/";
  static String detailsPage = "/detail";

  static void configRouters(Router router){
    //路由跳转,找不到对应页面处理.
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>>parms){
        //TODO...后续可以统一搞一个 商品不存在的页面.
        print('页面不存在!!!');
      }
    );

    //路由跳转,默认处理
    router.define(detailsPage, handler: detailHandler);
  }
}