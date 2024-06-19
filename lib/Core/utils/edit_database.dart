import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class USqlDb {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initiateDb();
    return _db;
  }

  initiateDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myDb.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return myDb;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //await db.execute('ALTER TABLE "notes" ADD COLUMN color');
    //db.execute('''CREATE TABLE 'profileImage' ('image' String)''');
    print('onUpgrade==============================');
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE 'meds' (
        'id' INTEGER NOT NULL PRIMARY KEY,
        'name' TEXT NOT NULL,
        'type' TEXT NOT NULL,
        'note' TEXT,
        'periods' TEXT NOT NULL,
        'isActive' INT NOT NULL,
        'isTaken' TEXT NOT NULL,
        'notificationIDs' TEXT ,
        'notificationTimes' TEXT ,
        'history' TEXT 
      )
    ''');
    await batch.commit();
    print('onCreate==============================');
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    print('inserted==================================');
    return response;
  }

  Future<List<Map<String, dynamic>>> read(String table) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(table);
    return response;
  }

  Future<int> update(
      String table, Map<String, Object?> values, String where) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: where);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<void> myDeleteDatabase() async {
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

  Future<int> updateIsTaken(int id, String isTaken) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      'meds',
      {'isTaken': isTaken},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('updateIsTaken==================================');
    return response;
  }
  Future<String?> getIsTaken(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['isTaken'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      print('getIsTaken==================================');
      return response.first['isTaken'];
    }
    return null;
  }

  // Update the value of notificationIDs
  Future<int> updateNotificationIDs(int id, String notificationIDs) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      'meds',
      {'notificationIDs': notificationIDs},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('updateNotificationIDs==================================');
    return response;
  }




  // Get the value of notificationIDs by id
  Future<String?> getNotificationIDs(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['notificationIDs'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      print('getNotificationIDs==================================');
      return response.first['notificationIDs'];
    }
    return null;
  }

  // Get the value of periods by id
  Future<String?> getPeriods(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['periods'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      print('getPeriods==================================');
      return response.first['periods'];
    }
    return null;
  }

  // Get the value of history by id
  Future<String?> getHistory(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['history'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      print('getHistory==================================');
      return response.first['history'];
    }
    return null;
  }

// Update the value of history
  // Update the value of history
  Future<int> updateHistory(int id, String history) async {
    Database? mydb = await db;
    String? currentHistory = await USqlDb().getHistory(id);

    // If there's no history yet, just set the new history
    if (currentHistory == null) {
      currentHistory = history;
    } else {
      // If there is existing history, append the new history
      currentHistory += history;

      // If the history is 7 days long, reset it to zeros
      if (currentHistory.length >= 7) {
        currentHistory = List.filled(7, '0').join('');
      }
    }

    // Update the history in the database
    int response = await mydb!.update(
      'meds',
      {'history': currentHistory},
      where: 'id = ?',
      whereArgs: [id],
    );

    print('updateHistory==================================');
    return response;
  }

  // Get the value of notificationTimes by id
  Future<String?> getNotificationTimes(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['notificationTimes'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      print('getNotificationTimes==================================');
      return response.first['notificationTimes'];
    }
    return null;
  }

// Update the value of notificationTimes
  Future<int> updateNotificationTimes(int id, String notificationTimes) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      'meds',
      {'notificationTimes': notificationTimes},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('updateNotificationTimes==================================');
    return response;
  }
}
