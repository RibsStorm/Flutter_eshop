import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'app_page.dart';
import 'application.dart';
import 'category/provide/category_provide.dart';
import 'detail/provide/detail_provide.dart';
import 'routers/routers.dart';

void main() {
  //使用Google Provide对数据进行管理
  var categoryProvide = CategoryProvide();
  var goodsDetailProvide = DetailProvide();

  var provides = Providers();
  provides
    ..provide(Provider<CategoryProvide>.value(categoryProvide))
    ..provide(Provider<DetailProvide>.value(goodsDetailProvide));
  runApp(ProviderNode(child: MyAPP(), providers: provides));
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Router的统一配置!!!
    final router = Router();
    Routers.configRouters(router);
    Application.router = router;
    //在MaterialAPP外面嵌套一层Container的目的是防止该项目后续的变更,提供更好的适应性
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(primaryColor: Colors.lightBlueAccent),
        debugShowCheckedModeBanner: false,
        home: AppPage(),
      ),
    );
  }
}
