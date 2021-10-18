import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/screens/friends/friends_profile_screen.dart';
import 'package:petmo/screens/pet/home_screen.dart';

import '../style.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(

      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            AppBar(
              title: Text('Friends List'),
              backgroundColor: PrimaryAccentColor,
              centerTitle: true,

            ),
            const SizedBox(height: 20),

            ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/friend1.PNG'), // no matter how big it is, it won't overflow
                ),
                title: const Text('Friend 1'),
                subtitle:
                    const Text("Pet Care Streak: 12🔥\nCurrently walking their pet"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const FriendsProfileScreen()));
                }),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/friend2.PNG'), // no matter how big it is, it won't overflow
              ),
              title: Text('Friend 2'),
              subtitle: Text(
                  "Pet Care Streak: 17🔥\nCurrently playing with their pet"),
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/friend3.PNG'), // no matter how big it is, it won't overflow
              ),
              title: Text('Friend 3'),
              subtitle: Text("Pet Care Streak: 6🔥\nActive 5 minutes ago"),
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/friend4.PNG'), // no matter how big it is, it won't overflow
              ),
              title: Text('Friend 4'),
              subtitle: Text("Pet Care Streak: 2🔥\nOffline"),
            ),
          ],
        ),
      ));
}
