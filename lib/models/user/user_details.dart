import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetails {
  static late final String name;
  static late final String profilePictureUrl;
  static late final String email;

  static Widget _ProfilePictureImage(BuildContext context) => Container(
        constraints: const BoxConstraints.expand(
          height: 250.0,
          width: 250.0,
        ),
        decoration: const BoxDecoration(color: Colors.grey),
        child: Image.network(
          profilePictureUrl,
          fit: BoxFit.cover,
          width: 200.0,
          height: 200.0,
          colorBlendMode: BlendMode.multiply,
        ),
      );

  static Widget _Name(BuildContext context) => Text(
    name,
  );

  static Widget _Email(BuildContext context) => Text(
    email,
  );
}
