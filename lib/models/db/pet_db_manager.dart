import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PetDBManager {
  static var database;

  static void initDb() async {
    database = openDatabase(
        join(await getDatabasesPath(), 'vp_database.db'),
    );
  }
}