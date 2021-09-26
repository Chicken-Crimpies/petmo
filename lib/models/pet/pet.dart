import 'package:flutter_guid/flutter_guid.dart';
import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';

class Pet {
  final Guid guid;
  final DateTime created;
  final List<PetAttribute> attributes;
  String name;
  bool isLocalPet;

  Pet(
      {required this.guid,
      required this.created,
      required this.attributes,
      required this.name,
      required this.isLocalPet});

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

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'created': created,
      'name': name,
      'happiness': getAttributeByKey("happiness")?.current,
      'health': getAttributeByKey("health")?.current,
      'hunger': getAttributeByKey("hunger")?.current,
      'walk': getAttributeByKey("walk")?.current,
      'local_pet': isLocalPet,
    };
  }

  @override
  String toString() {
    return 'Pet{guid: $guid, created: $created, name: $name, attributes $attributes, local_pet $isLocalPet}';
  }
}
