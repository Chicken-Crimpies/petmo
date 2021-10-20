import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/screens/pet/home_screen.dart';

import '../style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Petmo Profile'),
          backgroundColor: PrimaryAccentColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              constraints: const BoxConstraints.expand(
                height: 150.0,
                width: 150.0,
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
            SizedBox(height: 20),
            Text(
              'Pet Care Streak: ' + UserDetails.streak.toString() + ' 🔥',
              style: Body2TextStyle,
            ),
            SizedBox(height: 20),
            Text(
              'RSPCA Points: ' + UserDetails.points.toString() + ' 🦘',
              style: Body2TextStyle,
            ),
            SizedBox(height: 20),
            Text(
              'Next RSPCA 🔰 at 5000 points',
              style: Body2TextStyle,
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const HomeScreen()));
          },
          backgroundColor: PrimaryAccentColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ));
}
