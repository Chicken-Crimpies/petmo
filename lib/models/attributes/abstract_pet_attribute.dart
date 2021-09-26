import 'package:virtual_pet/models/attributes/happiness_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/health_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/hunger_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/walk_pet_attribute.dart';

abstract class PetAttribute {
  final String name;
  final int min, current, max;

  PetAttribute(this.name, this.min, this.current, this.max);

  void tick();

  static List<PetAttribute> buildAttributesFromDb(Map<String, dynamic> dbObj) {
    List<PetAttribute> attributes = List.empty();
    attributes.add(HappinessPetAttribute(dbObj['happiness']));
    attributes.add(HealthPetAttribute(dbObj['health']));
    attributes.add(HungerPetAttribute(dbObj['hunger']));
    attributes.add(WalkPetAttribute(dbObj['walk']));
    return attributes;
  }
}