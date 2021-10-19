import 'dart:async';

import 'package:path/path.dart';
import 'package:petmo/models/walk/walk.dart';
import 'package:sqflite/sqflite.dart';

class WalksDatabase {
  static final WalksDatabase instance = WalksDatabase._init();

  static Database? _database;

  WalksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('walks_database');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database database, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await database.execute('''
      CREATE TABLE $tableWalks (
      ${WalkFields.id} $idType,
      ${WalkFields.startPosition} $textType,
      ${WalkFields.endPosition} $textType,
      ${WalkFields.startTime} $textType,
      ${WalkFields.endTime} $textType,
      ${WalkFields.isActive} $boolType
      )
      ''');
  }

  Future<Walk> create(Walk walk) async {
    final database = await instance.database;
    final id = await database.insert(tableWalks, walk.toMap());
    return walk.copy(id: id);
  }

  Future<bool> doesActiveWalkExist() async {
    final List<Walk> walks = await getAllWalks();
    return walks.isNotEmpty;
  }

  Future<Walk> getActiveWalk() async {
    final List<Walk> walks = await getAllWalks();
    for (Walk walk in walks) {
      if (walk.isActive) return walk;
    }
    return walks.first;
  }

  Future<Walk> getWalkById(int id) async {
    final database = await instance.database;
    final maps = await database.query(
      tableWalks,
      columns: WalkFields.values,
      where: '${WalkFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Walk.fromMap(maps.first);
    } else {
      throw Exception('Walk id: $id , was not found in the database.');
    }
  }

  Future<List<Walk>> getAllWalks() async {
    final database = await instance.database;
    final orderBy = '${WalkFields.startTime} ASC';
    final result = await database.query(tableWalks, orderBy: orderBy);
    return result.map((map) => Walk.fromMap(map)).toList();
  }

  Future<int> update(Walk walk) async {
    final database = await instance.database;
    return database.update(
      tableWalks,
      walk.toMap(),
      where: '${WalkFields.id} = ?',
      whereArgs: [walk.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await instance.database;
    return await database.delete(
      tableWalks,
      where: '${WalkFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final database = await instance.database;
    database.close();
  }
}
