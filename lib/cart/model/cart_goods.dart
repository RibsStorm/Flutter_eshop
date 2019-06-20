class CartGoods {
  int id;
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  double oldPrice;

  CartGoods(
      {this.id,
      this.goodsId,
      this.goodsName,
      this.count,
      this.price,
      this.images,
      this.oldPrice});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['goodsId'] = goodsId;
    map['goodsName'] = goodsName;
    map['count'] = count;
    map['price'] = price;
    map['images'] = images;
    map['oldPrice'] = oldPrice;
    return map;
  }

  static CartGoods fromMap(Map<String, dynamic> map) {
    CartGoods goods = new CartGoods();
    goods.id = map['id'];
    goods.goodsId = map['goodsId'];
    goods.goodsName = map['goodsName'];
    goods.count = map['count'];
    goods.price = map['price'];
    goods.images = map['images'];
    goods.oldPrice = map['oldPrice'];
    return goods;
  }

  static List<CartGoods> fromMapList(List<Map<String, dynamic>> mapList) {
    List<CartGoods> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
