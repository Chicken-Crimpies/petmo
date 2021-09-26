import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  static var database;

  static void initDb() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'vp_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE pets(guid BLOB PRIMARY KEY, '
              'created TEXT, '
              'name TEXT, '
              'happiness INTEGER, '
              'health INTEGER, '
              'hunger INTEGER, '
              'walk INTEGER, '
              'local_pet INTEGER(1) NOT NULL, '
              'CONSTRAINT ck_local_pet_bool CHECK (local_pet IN (1, 0)))',
        );
      },
      version: 1,
    );
  }
}