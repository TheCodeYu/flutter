import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// description:数据库管理工具
///
/// user: yuzhou
/// date: 2021/6/20

///[DBManger]类，将数据库的创建，关闭等基础操作同一封装在一个类中统一管理
class DBManager {
  ///数据库版本
  static final int _dbVersion = 1;

  ///数据库名称
  static final String _dbName = 'crm.db';

  ///数据库实例
  static late Database _database;

  ///数据库初始化  Documents/crm.db
  static init() async {
    Sqflite.setDebugModeOn(true);
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);

    ///打开数据库,如果没有数据库则根据版本，名称，路劲在本地创建数据库并打开数据库
    ///指定[version]时，据库不存在，则调用 [onCreate]
    ///[onUpgrade] [onCreate] 未指定 数据库已经存在并且[版本]高于上一个数据库版本
    _database =
        await openDatabase(path, version: _dbVersion, onCreate: (db, version) {
      print("Create default table");
      //可以在这里创建表
    }, onConfigure: (db) {
      print("config default table");
    }, onOpen: (db) {
      print("open default table");
    }, onUpgrade: (db, oldVersion, newVersion) {
      print("upgrade default table");
    });
  }

  ///判断某个表是否存在
  static isTableExt(String tableName) async {
    await _getCurrentDatabase();
    String sql =
        "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _database.rawQuery(sql);
    return res.length > 0;
  }

  ///当前数据库实例
  static _getCurrentDatabase() => _database;

  static closeDatabase() => _database.close();
}

///[BaseDBProvider]类，这个类定义创建数据库表的基础方法；
///这个类是一个抽象类，把具体创建数据库表的sql暴露出去，让子类去具体实现；
///由它直接和DBManager打交道，业务层实现这个接口即可。
abstract class BaseDBProvider {
  bool isTableExits = false;

  ///有子类实现，返回创建表的具体sql
  String tableCreateSql();

  ///有子类实现，返回要创建的表名
  String tableName();

  ///返回表主键字段的基本sql定义，子类把其他字段的sql定义拼接到这个函数的返回值后面即可；
  String tabBaseString(String name, String columnId) {
    return '''
    create table $name (
    $columnId integer primary key autoincrement,
    ''';
  }

  ///返回一个数据库实例
  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  Future<void> prepare(name, String createSql) async {
    isTableExits = await DBManager.isTableExt(name);
    if (!isTableExits) {
      Database db = await DBManager._getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  Future<Database> open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableCreateSql());
    }
    return await DBManager._getCurrentDatabase();
  }
}
