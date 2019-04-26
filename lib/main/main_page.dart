import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("..."),
    );
  }

  Future<String> getContent() async {
    try {
      Dio _dio;
      Response _response;
    } catch (e) {
      print(e);
    }
  }
}
