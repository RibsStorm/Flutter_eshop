import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///首页商品分类展示列表
class MainCategoryLit extends StatelessWidget {
  List categoryList = [];

  MainCategoryLit({Key key,this.categoryList}):super(key:key);

  Widget categoryItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('还没写好');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['iamge'],
            width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setHeight(95),
          ),
          Text(item['mallCategoryName']),
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
      height: ScreenUtil().setHeight(320),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(6.0),
        children: categoryList.map((item) {
          categoryItem(context, item);
        }).toList(),
      ),
    );
  }
}
