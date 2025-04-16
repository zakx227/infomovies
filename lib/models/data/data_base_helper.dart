import 'dart:async';

import 'package:infomovis/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _init();
      return _db;
    }
    return _db;
  }

  Future<Database> _init() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "favorites.db");

    Database mydb = await openDatabase(path, onCreate: _createDb, version: 1);
    return mydb;
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "favorites" (
  "id" INTEGER PRIMARY KEY,
  "title" TEXT,
  "release_date" TEXT,
  "poster_path" TEXT,
  "overview" TEXT,
  "original_language" TEXT,
  "vote_count" INTEGER
);
    ''');
  }

  Future<int> insertData(Movie movie) async {
    Database? mydb = await db;
    return await mydb!.insert(
      'favorites',
      movie.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getAllData() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> maps = await mydb!.query('favorites');
    return maps.map((map) => Movie.fromJson(map)).toList();
  }

  Future<int> deleteData(int id) async {
    Database? mydb = await db;
    return await mydb!.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}
