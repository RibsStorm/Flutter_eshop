import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/mainpage_content.dart';

///首页商品分类展示列表
class MainCategoryList extends StatelessWidget {
  List<Category> categoryList = [];

  MainCategoryList({Key key, this.categoryList}) : super(key: key);

  Widget categoryItem(BuildContext context, Category item) {
    return InkWell(
      onTap: () {
        //TODO...通过商品ID跳转 待添加!
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(90),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(24),
            child: Text(
              item.mallCategoryName,
              style: TextStyle(fontSize: ScreenUtil().setSp(26)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //返回的商品类别有11个,不好摆,干脆阉掉一个.
    if (categoryList.length > 10) {
      categoryList.removeRange(10, categoryList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(260),
      padding: EdgeInsets.all(4.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(6.0),
        children: categoryList.map((item) {
          return categoryItem(context, item);
        }).toList(),
      ),
    );
  }
}
