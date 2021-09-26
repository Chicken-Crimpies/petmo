import 'package:virtual_pet/models/pet_attribute.dart';

class HappinessPetAttribute extends PetAttribute {

  HappinessPetAttribute(int current) : super("happiness", 0, current, 100);

  @override
  void tick() {
    // TODO: implement tick
  }
}