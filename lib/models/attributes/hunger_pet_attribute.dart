import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';

class HungerPetAttribute extends PetAttribute {

  HungerPetAttribute(int current) : super("hunger", 0, current, 100);

  @override
  void tick() {
    // TODO: implement tick
  }
}