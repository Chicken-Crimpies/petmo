abstract class AbstractManager {
  final String key;

  AbstractManager(this.key);

  void enable();
  void disable();
}