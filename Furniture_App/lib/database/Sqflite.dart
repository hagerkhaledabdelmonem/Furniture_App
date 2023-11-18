import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqflite{

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(),'appp.db');
    Database? myDB = await openDatabase(path,
        version: 2, onCreate: _onCreate);
    return myDB;
  }

  deleteDB() async {
    String databasePath = await getDatabasesPath();
    String databaseName = "appp.db";
    String path = join(databasePath, databaseName);
    await deleteDatabase(path);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS USER_CART (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      price NUMERIC NOT NULL,
      quantity INTEGER NOT NULL,
      image_link TEXT NOT NULL
    )
  ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS USER_FAVORITE (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      price NUMERIC NOT NULL,
      user_email TEXT NOT NULL,
      image_link TEXT NOT NULL
    )
  ''');
    print("Create=======================");
  }
  deleteData(String sql) async {
    Database? myDb = await database;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
  readData(String sql) async {
    Database? myDb = await database;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }
  // Shortcut
  myInsert(String table, Map<String, Object?> values) async {
    Database? myDb = await database;
    int response = await myDb!.insert(table, values);
    return response;
  }

  // Read
  myRead(String table) async {
    Database? myDb = await database;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  // Update
  myUpdate(String table, Map<String, Object?> values, String myWhere) async {
    Database? myDb = await database;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  // Delete
  myDelete(String table, String myWhere) async {
    Database? myDb = await database;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }

}