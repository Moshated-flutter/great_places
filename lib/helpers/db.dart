import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> addinsert(String table, Map<String, dynamic> data) async {
    final sqldb = await DbHelper.database();
    sqldb.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchdata(String table) async {
    final sqldb = await DbHelper.database();
    return sqldb.query(table);
  }
}
