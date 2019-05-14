import 'package:flutter/material.dart';

import '../model/category.dart';
import '../model/category_goods.dart';

class CategoryProvide with ChangeNotifier {
  List<CategoryItem> items = [];
  String categoryId;
  List<CategoryGoods> goodsList = [];

  getCategory(List<CategoryItem> list) {
//在数据源前面手动添加一个 全部
    CategoryItem all = CategoryItem();
    all.mallSubId = "";
    all.mallCategoryId = list.elementAt(0).mallCategoryId;
    all.mallSubName = "全部";

    items = [all];
    items.addAll(list);
    notifyListeners();
  }

  getCategoryItem(String categoryId) {
    this.categoryId = categoryId;
    notifyListeners();
  }

  getCategoryGoodsList(List<CategoryGoods> goodsList) {
    this.goodsList = goodsList;
    notifyListeners();
  }
}
