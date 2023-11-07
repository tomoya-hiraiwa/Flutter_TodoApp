import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQLiteHelper{
  static const _databaseName = 'Task.db';
  static const _databaseVersion = 1;
  static const table = 'books';

  static const id = '_id';
  static const title = 'title';
  static const text = 'text';
  static const date = 'date';

  SQLiteHelper._privateConstructor();
  static final SQLiteHelper instance = SQLiteHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,_databaseName);
    return await openDatabase(path,
    version: _databaseVersion,
    onCreate: _onCreate);
  }
  Future _onCreate(Database db,int version) async{
    await db.execute('''
    CREATE TABLE $table (
            $id INTEGER PRIMARY KEY,
            $title TEXT NOT NULL,
            $text TEXT NOT NULL,
            $date TEXT NOT NULL
          )
    ''');
  }
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }
  Future<List<Map<String, dynamic>>> getDataList() async {
    Database? db = await instance.database;

    var result = await db?.query(table);
    return result!;
  }
}