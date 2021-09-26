import 'package:flutter_guid/flutter_guid.dart';
import 'package:virtual_pet/models/pet_attribute.dart';

class Pet {
  final Guid guid;
  final DateTime created;
  final List<PetAttribute> attributes;
  String name;

  Pet(this.guid, this.created, this.attributes, this.name);

  PetAttribute? getAttributeByKey(String key) {
    for (PetAttribute petAttribute in attributes) {
      if (key.compareTo(petAttribute.name) == 0) {
        return petAttribute;
      }
    }
    return null;
  }

  void setName(String name) {
    this.name = name;
  }
}
