import 'package:flutter_guid/flutter_guid.dart';
import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';
import 'package:virtual_pet/models/managers/abstract_manager.dart';
import 'package:virtual_pet/models/managers/pet_db_manager.dart';
import 'package:virtual_pet/models/pet/pet.dart';

class PetManager extends AbstractManager {
  late Pet pet;
  List<Pet> pets;

  PetManager(this.pets) : super("Pet Manager");

  static void createNewPet(String _name) {
    var pet = Pet(
      guid: Guid.newGuid,
      created: DateTime.now(),
      attributes: PetAttribute.createDefaultAttributes(),
      name: _name,
      isLocalPet: true,
    );
    PetDBManager.insertPet(pet);
  }

  void setLocalPet(Pet pet) {
    this.pet = pet;
  }

  void setAllPets(List<Pet> pets) {
    this.pets = pets;
  }

  @override
  void enable() {
    // TODO: implement enable
  }

  @override
  void disable() {
    // TODO: implement disable
  }
}
