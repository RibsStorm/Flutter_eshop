import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../const/my_api.dart';

///获取首页主题内容
Future getMainPageContent() async{
  Response _response;
  Dio dio = new Dio();
  dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');

}