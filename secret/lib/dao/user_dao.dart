import 'package:secret/utils/sqlUtil.dart';
import 'package:sqflite/sqflite.dart';

/// description:用户信息表
///
/// user: yuzhou
/// date: 2021/6/20

class UserDao extends BaseDBProvider {
  ///表名
  final String name = 'user_info';

  ///表主键字段
  final String columnId = 'id';

  @override
  String tableCreateSql() {
    return tabBaseString(this.name, this.columnId) +
        '''
    id 
    ''';
  }

  @override
  String tableName() => this.name;

  ///插入一条新数据
  Future<int> insert() async {
    Database db = await getDataBase();
    return await db.insert(this.name, {});
  }
}
