import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';

class ExercisePetAttribute extends PetAttribute {

  ExercisePetAttribute(int current) : super('exercise', 0, current, 100);

  @override
  void tick() {
    // TODO: implement tick
  }
}