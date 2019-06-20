import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../cart/model/cart_goods.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  final String tableName = "table_cart";
  final String columnId = "id";
  final String columnGoodsId = "goodsId";
  final String columnGoodsName = "goodsName";
  final String columnCount = "count";
  final String columnPrice = "price";
  final String columnImages = "images";
  final String columnOldPrice = "oldPrice";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'eshop.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  //创建数据库表
  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,$columnGoodsId TEXT,$columnGoodsName TEXT, $columnCount INTEGER,$columnPrice REAL,$columnImages TEXT,$columnOldPrice REAL)",
    );
    print("Table is created");
  }

//插入
  Future<int> saveItem(CartGoods goods) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", goods.toMap());
    print("插入数据库: ========${res.toString()}");
    return res;
  }

  //查询
  Future<List<Map<String, dynamic>>> getTotalList() async {
    var dbClient = await db;
    List<Map<String, dynamic>> result =
        await dbClient.rawQuery("SELECT * FROM $tableName ");
    print("数据库里面的内容是: ========${result.toList().toString()}");
    return result;
  }

  //查询总数
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  //按照goodsId查询
  Future<int> getItemCount(String goodId) async {
    var dbClient = await db;
    List<Map> res = await dbClient.query(tableName,
        columns: [columnCount],
        where: '$columnGoodsId = ?',
        whereArgs: [goodId]);

    print("查询到的内容是: ========${res.toList().toString()}");
    if (res.length == 0) return null;
    return res.first[columnCount];
  }

  //清空数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }

  //根据goodsId删除
  Future<int> deleteItem(String goodId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: "$columnGoodsId = ?", whereArgs: [goodId]);
  }

  //根据商品ID来更新商品数量
  Future<int> updateItem(int itemCount, String goodsId) async {
    var dbClient = await db;
    return await dbClient.rawUpdate(
        'UPDATE $tableName SET $columnCount = ? WHERE $columnGoodsId = ? ',
        [itemCount, goodsId]);
  }

  //关闭
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
