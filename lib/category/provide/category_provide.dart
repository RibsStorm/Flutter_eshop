import 'package:flutter/material.dart';

import '../model/category.dart';
import '../model/category_goods.dart';

class CategoryProvide with ChangeNotifier {
  List<CategoryItem> items = [];
  List<CategoryGoods> goodsList = [];
//商品的二级分类,都是都是选中第一个, 全部
  int childIndex = 0;
//商品的顶部二级分类列表 点击对应的 三级分类ID
  String categorySubId;

  getCategory(int childIndex,List<CategoryItem> list) {
    //在数据源前面手动添加一个 全部
    //默认选中第一个,进行高亮
    this.childIndex = childIndex;
    CategoryItem all = CategoryItem();
    all.mallSubId = "";
    all.mallCategoryId = list.elementAt(0).mallCategoryId;
    all.mallSubName = "全部";

    items = [all];
    items.addAll(list);
    notifyListeners();
  }

  getCategoryGoodsList(List<CategoryGoods> goodsList) {
    this.goodsList = goodsList;
    notifyListeners();
  }
}
