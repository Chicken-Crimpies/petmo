import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import 'friends_list_screen.dart';

class FriendsProfileScreen extends StatelessWidget {
  const FriendsProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Friend's name",
              style: TitleTextStyle,
            ),
            SizedBox(height: 20),
            Text(
              'Pet Care Streak: 10🔥',
              style: TitleTextStyle,
            ),
            SizedBox(height: 20),
            Text(
              'Currently active',
              style: TitleTextStyle,
            ),
            SizedBox(height: 20),
            Container(
              height: 250.0,
              width: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/friend1.PNG'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Color(0xff584B53),
              ),
              onPressed: () {},
              child: Text('Send a walk request'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Color(0xff584B53),
              ),
              onPressed: () {},
              child: Text('Send a reminder to feed their pet'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Color(0xff584B53),
              ),
              onPressed: () {},
              child: Text('Send a reminder to play with their pet'),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => FriendsScreen()));
          },
          backgroundColor: Color(0xff584B53),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}
