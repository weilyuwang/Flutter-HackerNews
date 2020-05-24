import 'package:flutter_hackernews/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // to work with underlying file system
import 'dart:io';
import 'package:path/path.dart';
import '../models/item_model.dart';
import 'dart:async';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    // open the database
    init();
  }

  // function to create or reopen the database
  // need to call init() first before we can use NewsDbProvider instance
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INT,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
        """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      "Items",
      columns: null, // => set column to null will get all the columns
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.elementAt(0));
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  // method to clear cache
  Future<int> clear() {
    return db.delete("Items");
  }
}

// only create one NewsDbProvider instance
final newsDbProvider = NewsDbProvider();
