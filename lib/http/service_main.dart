import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../const/my_api.dart';

///获取首页主题内容
Future getMainPageContent() async {
  try {
    Response _response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    _response = await dio.post(servicePath['homePageContext'],
        data: {'lon': '115.02932', 'lat': '35.76189'});

    if (_response.statusCode == 200) {
      return _response.data;
    } else {
      throw Exception('接口请求异常');
    }
  } catch (e) {
    print('接口请求异常:=======$e========');
  }
}
