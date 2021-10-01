import 'dart:async';

import 'package:path/path.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:sqflite/sqflite.dart';

class PetsDatabase {
  static final PetsDatabase instance = PetsDatabase._init();

  static Database? _database;

  PetsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('pets_database');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    print('[LOG] ' + dbPath);
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database database, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await database.execute('''
      CREATE TABLE $tablePets (
      ${PetFields.id} $idType,
      ${PetFields.name} $textType,
      ${PetFields.created} $textType,
      ${PetFields.exercise} $integerType,
      ${PetFields.happiness} $integerType,
      ${PetFields.health} $integerType,
      ${PetFields.hunger} $integerType,
      ${PetFields.isLocalPet} $boolType
      )
      ''');
  }

  Future<Pet> create(Pet pet) async {
    final database = await instance.database;
    final id = await database.insert(tablePets, pet.toMap());
    return pet.copy(id: id);
  }

  Future<bool> doesLocalPetExist() async {
    final List<Pet> pets = await getAllPets();
    return pets.isNotEmpty;
  }

  Future<Pet> getLocalPet() async {
    final List<Pet> pets = await getAllPets();
    for (Pet pet in pets) {
      if (pet.isLocalPet) return pet;
    }
    print('[LOG] Error fetching local pet, returned first pet instead.');
    return pets.first;
  }

  Future<Pet> getPetById(int id) async {
    final database = await instance.database;
    final maps = await database.query(
      tablePets,
      columns: PetFields.values,
      where: '${PetFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Pet.fromMap(maps.first);
    } else {
      throw Exception('Pet id: $id , was not found in the database.');
    }
  }

  Future<List<Pet>> getAllPets() async {
    final database = await instance.database;
    final orderBy = '${PetFields.created} ASC';
    final result = await database.query(tablePets, orderBy: orderBy);
    return result.map((map) => Pet.fromMap(map)).toList();
  }

  Future<int> update(Pet pet) async {
    final database = await instance.database;
    return database.update(
      tablePets,
      pet.toMap(),
      where: '${PetFields.id} = ?',
      whereArgs: [pet.id],
    );
  }

  Future<int> delete(int id) async {
    final database = await instance.database;
    return await database.delete(
      tablePets,
      where: '${PetFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final database = await instance.database;
    database.close();
  }
}
