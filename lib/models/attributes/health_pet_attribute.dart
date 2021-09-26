import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';

class HealthPetAttribute extends PetAttribute {

  HealthPetAttribute(int current) : super("Health", 0, current, 100);

  @override
  void tick() {
    // TODO: implement tick
  }
}