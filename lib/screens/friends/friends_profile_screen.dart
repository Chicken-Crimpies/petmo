import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/models/user/friend.dart';

import '../style.dart';
import 'friends_list_screen.dart';

class FriendsProfileScreen extends StatefulWidget {
  final Friend friend;

  const FriendsProfileScreen({Key? key, required this.friend}) : super(key: key);

  @override
  _FriendsProfileScreenState createState() => _FriendsProfileScreenState();
}

class _FriendsProfileScreenState extends State<FriendsProfileScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [SecondaryAccentColor, LightAccentColor])),
    child: Scaffold(
      appBar: AppBar(
        title: Text('Petmo Profile: ' + widget.friend.name),
        backgroundColor: PrimaryAccentColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints.expand(
                height: 250.0,
                width: 250.0,
              ),
              decoration: const BoxDecoration(color: Colors.grey),
              child: Image.network(
                widget.friend.imageUrl,
                fit: BoxFit.cover,
                width: 200.0,
                height: 200.0,
                colorBlendMode: BlendMode.multiply,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.friend.name,
              style: TitleTextStyle,
            ),
            const SizedBox(height: 20),
            Text(
              'Pet Care Streak: ' + widget.friend.streak.toString() + ' 🔥',
              style: TitleTextStyle,
            ),
            const SizedBox(height: 20),
            Text(
              'RSPCA Points: ' + widget.friend.points.toString() + ' 🦘',
              style: TitleTextStyle,
            ),
            const SizedBox(height: 20),
            const Text(
              'Currently active',
              style: TitleTextStyle,
            ),
            const SizedBox(height: 0),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                onTap: _sendWalkRequest,
                child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x80000000),
                            blurRadius: 12.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            PrimaryAccentColor,
                            TertiaryAccentColor,
                          ],
                        )),
                    child: const Center(
                      child: Text('Walk Request'),
                    ))),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x80000000),
                                blurRadius: 12.0,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                PrimaryAccentColor,
                                TertiaryAccentColor,
                              ],
                            )),
                        child: const Center(
                          child: Text('Feed Reminder'),
                        ))),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x80000000),
                                blurRadius: 12.0,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                PrimaryAccentColor,
                                TertiaryAccentColor,
                              ],
                            )),
                        child: const Center(
                          child: Text('Play Reminder'),
                        ))),
              ],
            ),
            )])
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //       backgroundColor: PrimaryAccentColor,
          //     ),
          //     onPressed: () {},
          //     child: Text('Send a walk request'),
          //   ),
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //       backgroundColor: PrimaryAccentColor,
          //     ),
          //     onPressed: () {},
          //     child: Text('Send a reminder to feed their pet'),
          //   ),
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //       backgroundColor: PrimaryAccentColor,
          //     ),
          //     onPressed: () {},
          //     child: Text('Send a reminder to play with their pet'),
          //   )
          // ]
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const FriendsScreen()));
          },
          backgroundColor: PrimaryAccentColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ));

  void _sendWalkRequest() async {
    print('running');

    print(await FirebaseMessaging.instance.getToken());

    FirebaseFirestore.instance.collection('notifications').add({
      'receiver': widget.friend.email,
      'token': widget.friend.token,
    });
  }
}
