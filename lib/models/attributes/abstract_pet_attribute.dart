import 'package:virtual_pet/models/attributes/happiness_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/health_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/hunger_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/walk_pet_attribute.dart';

import 'dart:math';

abstract class PetAttribute {
  final String name;
  final int min, current, max;

  PetAttribute(this.name, this.min, this.current, this.max);

  void tick();

  static List<PetAttribute> buildAttributesFromDb(Map<String, dynamic> dbObj) {
    List<PetAttribute> attributes = List.empty(growable: true);
    attributes.add(HappinessPetAttribute(dbObj['happiness']));
    attributes.add(HealthPetAttribute(dbObj['health']));
    attributes.add(HungerPetAttribute(dbObj['hunger']));
    attributes.add(WalkPetAttribute(dbObj['walk']));
    return attributes;
  }

  static List<PetAttribute> createDefaultAttributes() {
    var rand = Random();
    List<PetAttribute> attributes = List.empty(growable: true);
    attributes.add(HappinessPetAttribute(50 + rand.nextInt(50)));
    attributes.add(HealthPetAttribute(50 + rand.nextInt(50)));
    attributes.add(HungerPetAttribute(50 + rand.nextInt(50)));
    attributes.add(WalkPetAttribute(50 + rand.nextInt(50)));
    return attributes;
  }
}