import 'package:flutter/material.dart';
import 'package:flutter_eshop/app_page.dart';

void main() => runApp(MyAPP());

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //在MaterialAPP外面嵌套一层Container的目的是防止该项目后续的变更,提供更好的适应性
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        theme: ThemeData(
          primaryColor: Colors.pinkAccent
        ),
        debugShowCheckedModeBanner: false,
        home: AppPage(),
      ),
    );
  }
}
