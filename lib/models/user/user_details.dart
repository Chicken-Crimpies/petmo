import 'package:flutter/material.dart';

class UserDetails {
  static late final String name;
  static late final String profilePictureUrl;
  static late final String email;
  static late int points;
  static late int streak = 0;

  static Map<String, dynamic> toMap() {
    Map<String, dynamic> details = <String, dynamic>{};
    details.putIfAbsent('email', () => email);
    details.putIfAbsent('imageUrl', () => profilePictureUrl);
    details.putIfAbsent('name', () => name);
    details.putIfAbsent('points', () => points);
    details.putIfAbsent('streak', () => streak);
    return details;
  }
}
