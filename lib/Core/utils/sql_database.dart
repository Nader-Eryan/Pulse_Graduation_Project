import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  Database? _db;
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initiateDb();
    return _db;
  }

  initiateDb() async {
    //print('initDb==============');
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myDb.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //await db.execute('ALTER TABLE "notes" ADD COLUMN color');
    //db.execute('''CREATE TABLE 'profileImage' ('image' String)''');
    print('onUpgrade==============================');
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
        '''
      CREATE TABLE 'meds' (
        'id' INTEGER NOT NULL PRIMARY KEY,
        'name' TEXT NOT NULL,
        'type' TEXT NOT NULL,
        'note' TEXT,
        'periods' TEXT NOT NULL,
        'isActive' INT NOT NULL,
        'isTaken' INT NOT NULL
      )
    ''');
    await batch.commit();
    print('onCreate==============================');
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  insert(
    String table,
    Map<String, Object?> values,
  ) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    print('inserted==================================');

    return response;
  }

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  update(
    String table,
    Map<String, Object?> values,
    String? where,
  ) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: where);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  myDeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myDb.db');
    await deleteDatabase(path);
  }

  Future<void> deleteAllRows(String tableName) async {
    Database? mydb = await db;
    if (mydb != null) {
      await mydb.delete(tableName);
    }
  }
}
