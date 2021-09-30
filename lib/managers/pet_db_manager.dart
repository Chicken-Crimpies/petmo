import 'abstract_manager.dart';

class PetDBManager extends AbstractManager {
  PetDBManager() : super("Pet DB Manager");

  //
  // static Future<void> insertPet(Pet pet) async {
  //   final db = await DBHandler.database;
  //
  //   if (db == null) print('[LOG] db is null');
  //
  //   await db.insert(
  //     'pets',
  //     pet.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   print('[LOG] insertion of pet: ' + pet.name + ', completed');
  // }
  //
  // static Future<void> updatePet(Pet pet) async {
  //   final db = await DBHandler.database;
  //
  //   await db.update(
  //     'pets',
  //     pet.toMap(),
  //     where: 'guid = ?',
  //     whereArgs: [pet.guid],
  //   );
  // }
  //
  // static Future<void> deletePet(Guid guid) async {
  //   final db = await DBHandler.database;
  //
  //   await db.delete(
  //     'pets',
  //     where: 'guid = ?',
  //     whereArgs: [guid],
  //   );
  // }
  //
  // static Future<List<Pet>> retrievePets() async {
  //   final db = await DBHandler.database;
  //
  //   final List<Map<String, dynamic>> maps = await db.query('pets');
  //
  //   return List.generate(maps.length, (i) {
  //     Pet pet = Pet(
  //       guid: Guid(maps[i]['guid']),
  //       created: DateTime.parse(maps[i]['created']),
  //       attributes: PetAttribute.buildAttributesFromDb(maps[i]),
  //       name: maps[i]['name'],
  //       isLocalPet: maps[i]['local_pet'] == 1 ? true : false,
  //     );
  //     return pet;
  //   });
  // }
  //
  @override
  void enable() {
    // TODO: implement enable
  }

  @override
  void disable() {
    // TODO: implement disable
  }
}
