import 'package:petmo/models/attributes/abstract_pet_attribute.dart';

final String tablePets = 'pets';

class PetFields {
  static final List<String> values = [
    id,
    name,
    created,
    exercise,
    happiness,
    health,
    hunger,
    isLocalPet
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String created = 'created';
  static final String exercise = 'exercise';
  static final String happiness = 'happiness';
  static final String health = 'health';
  static final String hunger = 'hunger';
  static final String isLocalPet = 'isLocalPet';
}

class Pet {
  final int? id;
  final String name;
  final DateTime created;
  final List<PetAttribute> attributes;
  final bool isLocalPet;

  const Pet({
    this.id,
    required this.name,
    required this.created,
    required this.attributes,
    required this.isLocalPet,
  });

  Map<String, dynamic> toMap() => {
        PetFields.id: id,
        PetFields.name: name,
        PetFields.created: created.toIso8601String(),
        PetFields.exercise: attributes
            .firstWhere(
                (attribute) => attribute.name.compareTo('exercise') == 0)
            .current,
        PetFields.happiness: attributes
            .firstWhere(
                (attribute) => attribute.name.compareTo('happiness') == 0)
            .current,
        PetFields.health: attributes
            .firstWhere((attribute) => attribute.name.compareTo('health') == 0)
            .current,
        PetFields.hunger: attributes
            .firstWhere((attribute) => attribute.name.compareTo('hunger') == 0)
            .current,
        PetFields.isLocalPet: isLocalPet ? 1 : 0,
      };

  Pet copy({
    int? id,
    String? name,
    DateTime? created,
    List<PetAttribute>? attributes,
    bool? isLocalPet,
  }) =>
      Pet(
        id: id ?? this.id,
        name: name ?? this.name,
        created: created ?? this.created,
        attributes: attributes ?? this.attributes,
        isLocalPet: isLocalPet ?? this.isLocalPet,
      );

  int getAttributeCurrentByKey(String key) {
    return attributes.firstWhere((element) => element.name == key).current;
  }

  static Pet fromMap(Map<String, dynamic> map) => Pet(
    id: map[PetFields.id] as int?,
    name: map[PetFields.name] as String,
    created: DateTime.parse(map[PetFields.created] as String),
    attributes: PetAttribute.buildAttributesFromMap(map),
    isLocalPet: map[PetFields.isLocalPet] == 1,
  );
}
