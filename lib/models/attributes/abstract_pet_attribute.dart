import 'package:virtual_pet/models/attributes/happiness_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/health_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/hunger_pet_attribute.dart';
import 'package:virtual_pet/models/attributes/exercise_pet_attribute.dart';

import 'dart:math';

import 'package:virtual_pet/models/pet/pet_db_object.dart';

abstract class PetAttribute {
  final String name;
  final int min, current, max;

  PetAttribute(this.name, this.min, this.current, this.max);

  void tick();

  static List<PetAttribute> buildAttributesFromMap(Map<String, dynamic> dbObj) {
    List<PetAttribute> attributes = List.empty(growable: true);
    attributes.add(ExercisePetAttribute(dbObj[PetFields.exercise]));
    attributes.add(HappinessPetAttribute(dbObj[PetFields.happiness]));
    attributes.add(HealthPetAttribute(dbObj[PetFields.health]));
    attributes.add(HungerPetAttribute(dbObj[PetFields.hunger]));
    return attributes;
  }

  static List<PetAttribute> createDefaultAttributes() {
    var rand = Random();
    List<PetAttribute> attributes = List.empty(growable: true);
    attributes.add(ExercisePetAttribute(50 + rand.nextInt(50)));
    attributes.add(HappinessPetAttribute(50 + rand.nextInt(50)));
    attributes.add(HealthPetAttribute(50 + rand.nextInt(50)));
    attributes.add(HungerPetAttribute(50 + rand.nextInt(50)));
    return attributes;
  }
}