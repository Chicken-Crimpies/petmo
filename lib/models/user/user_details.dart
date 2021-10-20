class UserDetails {
  static late String name;
  static late String profilePictureUrl;
  static late String email;
  static late int points;
  static late int streak = 0;

  static Map<String, dynamic> toMap() {
    Map<String, dynamic> details = <String, dynamic>{};
    details.putIfAbsent('email', () => email);
    details.putIfAbsent('imageUrl', () => profilePictureUrl);
    details.putIfAbsent('name', () => name);
    details.putIfAbsent('points', () => points);
    details.putIfAbsent('streak', () => streak);
    details.putIfAbsent('lastActivity', () => DateTime.now().toIso8601String());
    return details;
  }
}
