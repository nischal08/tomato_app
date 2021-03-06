import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'cart.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE cart(id TEXT PRIMARY KEY,title TEXT,image TEXT,restaurantName TEXT,categoryName TEXT, quantity REAL, price REAL, totalPrice REAL)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> remove(String table, id) async {
    final db = await database();
    db.delete(
      table,
      where: "id=?",
      whereArgs: [id],
    );
  }

  static Future<void> removeAll(String table) async {
    final db = await database();
    db.delete(table);
  }

  static Future<void> update(String table, {mapData, id}) async {
    final db = await database();

    db.update(table, mapData,
        where: "id=?",
        whereArgs: [id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }
}
