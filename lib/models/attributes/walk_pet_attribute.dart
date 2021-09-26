import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';

class WalkPetAttribute extends PetAttribute {

  WalkPetAttribute(int current) : super("walk", 0, current, 100);

  @override
  void tick() {
    // TODO: implement tick
  }
}