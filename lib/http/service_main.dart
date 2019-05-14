import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../const/my_api.dart';

///获取首页主题内容
Future postRequest(type, {data}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');

    response = data == null
        ? await dio.post(servicePath[type])
        : await dio.post(servicePath[type], data: data);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('接口请求异常');
    }
  } catch (e) {
    print('接口请求异常:=======$e========');
  }
}

//想把首页的2个接口通过dio整合成一个,
//map处理有点问题,应该是我姿势不对
//Future postRequestForMore() async {
//  try {
//    int currentPage = 1;
//    List<Response> response;
//    List result = [];
//    Dio dio = Dio();
//    dio.options.contentType =
//        ContentType.parse('application/x-www-form-urlencoded');
//
//    response = await Future.wait([
//      dio.post(servicePath['homePageContext'],
//          data: {'lon': '115.02932', 'lat': '35.76189'}),
//      dio.post(servicePath['hotGoodsList'], data: currentPage),
//    ]);
//
//    if (response[0].statusCode == 200 && response[1].statusCode == 200) {
//      return response.map((response) => result.add(response.data));
//    } else {
//      throw Exception('接口请求异常');
//    }
//  } catch (e) {}
//}
