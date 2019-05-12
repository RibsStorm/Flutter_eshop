import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryProvide with ChangeNotifier {
  List<CategoryItem> items;

  getCategory(List list) {
    items = list;
    notifyListeners();
  }
}
