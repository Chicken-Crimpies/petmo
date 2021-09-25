abstract class PetAttribute {
  final String name;
  final int min, current, max;

  PetAttribute(this.name, this.min, this.current, this.max);

  void tick();
}