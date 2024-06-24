import 'dart:async';

import 'package:pulse/Core/utils/functions/notification_model.dart';
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
    //print('onUpgrade==============================');
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
        'isTaken' INT NOT NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE 'notifications' (
        'id' INTEGER NOT NULL PRIMARY KEY,
        'medId' INTEGER NOT NULL,
        'notificationTime' TEXT,
        'indexOfNotification' INT NOT NULL,
        FOREIGN KEY (medId) REFERENCES meds (id)
      )
    ''');
    batch.execute('''
      CREATE TABLE 'medHistory' (
        'id' INTEGER NOT NULL PRIMARY KEY,
        'medId' INTEGER NOT NULL,
        'history' TEXT NOT NULL,
        FOREIGN KEY (medId) REFERENCES meds (id)
      )
    ''');
    await batch.commit();
    //print('onCreate==============================');
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
    //print('inserted==================================');

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

  Future<String?> getMedName(int medId) async {
    try {
      Database? mydb = await db;
      List<Map<String, dynamic>> response = await mydb!.query(
        'meds',
        columns: ['name'],
        where: 'id = ?',
        whereArgs: [medId],
      );
      if (response.isNotEmpty) {
        // print('getMedName==================================');
        return response.first['name'];
      }
      return null;
    } catch (e) {
      //print("Error getting med name: $e");
      return null;
    }
  }

  Future<int> insertNotification(NotificationModel notification) async {
    Database? mydb = await db;
    int response = await mydb!.insert('notifications', notification.toMap());
    //print('Notification inserted==================================');
    return response;
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query('notifications');
    return response.map((map) => NotificationModel.fromMap(map)).toList();
  }

  Future<List<NotificationModel>> getNotificationsForMed(int medId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'notifications',
      where: 'medId = ?',
      whereArgs: [medId],
    );
    return response.map((map) => NotificationModel.fromMap(map)).toList();
  }

  Future<int> updateIsTaken(int medId, int isTaken) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      'meds',
      {'isTaken': isTaken},
      where: 'id = ?',
      whereArgs: [medId],
    );
    return response;
  }

  Future<int?> getIsTaken(int medId) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['isTaken'],
      where: 'id = ?',
      whereArgs: [medId],
    );
    if (response.isNotEmpty) {
      return response.first['isTaken'] as int?;
    }
    return null;
  }

  Future<String?> getPeriods(int id) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      'meds',
      columns: ['periods'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (response.isNotEmpty) {
      //print('getPeriods==================================');
      return response.first['periods'];
    }
    return null;
  }

  Future<int> insertMedHistory(int medId, String history) async {
    try {
      Database? mydb = await db;
      int response = await mydb!.insert('medHistory', {
        'medId': medId,
        'history': history,
      });
      //print('Inserted into medHistory==================================');
      return response;
    } catch (e) {
      //print("Error inserting into medHistory: $e");
      return -1;
    }
  }

  Future<String?> getHistory(int medId) async {
    try {
      Database? mydb = await db;
      List<Map<String, dynamic>> response = await mydb!.query(
        'medHistory',
        columns: ['history'],
        where: 'medId = ?',
        whereArgs: [medId],
      );
      if (response.isNotEmpty) {
        //print('getHistory==================================');
        return response.first['history'];
      }
      return null;
    } catch (e) {
      //print("Error getting history: $e");
      return null;
    }
  }

  Future<int> updateHistory(int medId, String history) async {
    try {
      Database? mydb = await db;
      String? currentHistory = await getHistory(medId);

      if (currentHistory == null) {
        currentHistory = history;
        //print(currentHistory);
      } else {
        currentHistory += history;
        if (currentHistory.length >= 7) {
          currentHistory = List.filled(7, '0').join('');
        }
      }

      int response = await mydb!.update(
        'medHistory',
        {'history': currentHistory},
        where: 'medId = ?',
        whereArgs: [medId],
      );

      //print('updateHistory==================================');
      return response;
    } catch (e) {
      //print("Error updating history: $e");
      return -1;
    }
  }
}
