import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:petmo/screens/pet/pet_screen.dart';

import '../style.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
        body: ListView(
          children: const <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                size: 56,
              ),
              title: Text('Friend 1'),
              subtitle:
                  Text('Pet Care Streak: 2🔥\nCurrently walking their pet'),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                size: 56,
              ),
              title: Text('Friend 2'),
              subtitle: Text(
                  'Pet Care Streak: 17🔥\nCurrently playing with their pet'),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                size: 56,
              ),
              title: Text('Friend 3'),
              subtitle: Text('Pet Care Streak: 8🔥\nActive 5 minutes ago'),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_rounded,
                size: 56,
              ),
              title: Text('Friend 4'),
              subtitle: Text('Pet Care Streak: 3🔥\nOffline'),
            ),
          ],
        ),
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
      ));
}
