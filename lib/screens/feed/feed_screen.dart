import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/screens/pet/home_screen.dart';

import '../style.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Petmo Feeding'),
          backgroundColor: PrimaryAccentColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Stack(children: [
          Center(child: Image.asset('assets/images/kangaroo_eating_clear.gif')),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                        onTap: () => {
                              UserDetails.points += 10,
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: UserDetails.email)
                                  .get()
                                  .then((value) => value.docs[0].reference
                                      .update(UserDetails.toMap())),
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Petmo Fed',
                                              style: TitleTextStyle),
                                          content: Text(
                                            'Points Earned: 5',
                                            style: Body1TextStyle,
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Icon(Icons.close))
                                          ]))
                            },
                        child: Container(
                            height: 60,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x80000000),
                                    blurRadius: 6.0,
                                    offset: Offset(5.0, 5.0),
                                  )
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
                              child: Text(
                                'Feed',
                                style: Body2TextStyle,
                              ),
                            ))))
              ])
        ]),
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
