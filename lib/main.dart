import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'app_page.dart';
import 'category/provide/category_provide.dart';

void main() {
  //使用Google Provide对数据进行管理
  var categoryProvide = CategoryProvide();

  var provides = Providers();
  provides..provide(Provider<CategoryProvide>.value(categoryProvide));
  runApp(ProviderNode(child: MyAPP(), providers: provides));
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //在MaterialAPP外面嵌套一层Container的目的是防止该项目后续的变更,提供更好的适应性
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        theme: ThemeData(primaryColor: Colors.lightBlueAccent),
        debugShowCheckedModeBanner: false,
        home: AppPage(),
      ),
    );
  }
}
