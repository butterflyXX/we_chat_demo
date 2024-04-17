import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class SqliteTableApi {
  late final Database db;
  String dbName;
  String table;
  String createSq;

  SqliteTableApi({required this.dbName, required this.table, required this.createSq});

  Future load() async {
    db = await SqliteUtil.open(dbName);
    final isExist = await SqliteUtil.isTableExits(db, table);
    print("$dbName 表是否存在 >>> $isExist");
    if (!isExist) {
      //创建表
      print("创建表......");
      SqliteUtil.execute(db, createSq);
    }
  }

  Future insert(Map<String, dynamic> paramters) async {
    return await SqliteUtil.insert(db, table, paramters);
  }

  Future<List> getList({String orderBy = 'id desc', int limit = 50}) async {
    return await SqliteUtil.getList(db: db, tableName: table, orderBy: orderBy, limit: limit);
  }
}

class SqliteUtil {

  ///打开DB
  static Future<Database> open(String dbName) async {
    String path = await getPath(dbName);
    return await openDatabase(path);
  }

  ///数据库是否存在某个表
  static Future<bool> isTableExits(Database db, String tableName) async {
    var sql ="SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'";
    var res = await db.rawQuery(sql);
    return res.isNotEmpty;
  }

  ///获取数据库路径
  static Future<String> getPath(String dbName) async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    return path;
  }

  ///执行sq语句
  static Future execute(Database db, String sqliteString) async {
    await db.execute(sqliteString);
  }

  ///sql助手插入
  static Future insert(Database db, String tableName, Map<String, dynamic> paramters) async {
    var result = await db.insert(tableName, paramters);
    return result;
  }

  static Future<List> getList({required Database db, required String tableName, String? orderBy, int? limit}) async {
    var result = await db.query(
      tableName,
      orderBy: 'id desc',
      limit: limit,
    );
    return result.toList();
  }
}
