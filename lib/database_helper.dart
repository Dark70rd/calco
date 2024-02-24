import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return Future.value(_db!);
    }
    _db = await setDB();
    return _db!;
  }

  DatabaseHelper.internal();

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}main.db";
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE history(id INTEGER PRIMARY KEY, equation TEXT, result TEXT)");
    print("Table is created");
  }

  // Insertion
  Future<int> saveUser(String equation, String result) async {
    var dbClient = await db;
    int res = await dbClient
        .insert("history", {'equation': equation, 'result': result});
    return res;
  }

  // Deletion
  Future<int> deleteUser(String equation) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM history WHERE equation = ?', [equation]);
    return res;
  }

  // Get all equations
  Future<List<Map<String, String>>> getHistory() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM history');
    List<Map<String, String>> history = [];
    for (int i = 0; i < list.length; i++) {
      history
          .add({'equation': list[i]["equation"], 'result': list[i]["result"]});
    }
    return history;
  }
}
