import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // to work with underlying file system
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  // function to create or reopen the database
  init() async {
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

  fetchItem(int id) async {
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

  addItem(ItemModel item) {
    return db.insert("Items", item.toMap());
  }
}
