// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:todo_list_algoriza/models/task.dart';

class DBHelper {
  static Database? db;
  static final int version = 1;
  static final String tableName = "tasks";

  static Future<void> initDB() async {
    if (db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + "tasks.db";
      db = await openDatabase(path, version: version, onCreate: (db, version) {
        print('creating a new one');
        return db.execute("CREATE TABLE $tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT, date STRING,"
            "startTime STRING, endTIME STRING,"
            "remind STRING, repeat STRING,"
            "color INTEGER,"
            " isCompleted INTEGER,"
            ") ");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print('fn is called');
    return await db?.insert(tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await db!.query(tableName);
  }

  static deleteTask(Task task) async {
    return await db!.delete(tableName, where: 'id', whereArgs: [task.id]);
  }

  static updateTask(int id) async {
    return await db!.rawUpdate('''
          UPDATE tasks
          SET isCompleted = ?
          WHERE id = ?
     ''', [1, id]);
  }
}
