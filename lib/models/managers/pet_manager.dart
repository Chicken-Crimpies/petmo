import 'package:virtual_pet/models/managers/abstract_manager.dart';
import 'package:virtual_pet/models/pet/pet.dart';

class PetManager extends AbstractManager {
  List<Pet> pets;

  PetManager(this.pets) : super("Pet Manager");

  @override
  void enable() {
    // TODO: implement enable

  }

  @override
  void disable() {
    // TODO: implement disable
  }
}