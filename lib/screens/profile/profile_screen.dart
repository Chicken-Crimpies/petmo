import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import '../style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile',
              style: TitleTextStyle,
            ),
            SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints.expand(
                height: 250.0,
                width: 250.0,
              ),
              decoration: const BoxDecoration(color: Colors.grey),
              child: Image.network(
                UserDetails.profilePictureUrl,
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
                colorBlendMode: BlendMode.multiply,
              ),
            ),
            SizedBox(height: 20),
            Text(
              UserDetails.name,
              style: TitleTextStyle,
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PetScreen()));
          },
          backgroundColor: Color(0xff584B53),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}
