import 'package:flutter_guid/flutter_guid.dart';
import 'package:virtual_pet/managers/pet_db_manager.dart';
import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';
import 'package:virtual_pet/models/pet/pet_db_object.dart';

import 'abstract_manager.dart';

class PetManager extends AbstractManager {
  bool isPetSet;
  List<Pet> pets;
  late Pet pet;

  PetManager(this.isPetSet, this.pets) : super("Pet Manager");

  // static Pet createNewPet(String _name) {
    // var pet = Pet(
    //   id,
    //   created: DateTime.now(),
    //   attributes: PetAttribute.createDefaultAttributes(),
    //   name: _name,
    //   isLocalPet: true,
    // );
    // PetDBManager.insertPet(pet);
    // return pet;
  // }

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
