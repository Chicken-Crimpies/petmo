import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/models/user/friend.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/screens/pet/home_screen.dart';

import '../style.dart';
import 'friends_profile_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  List<Widget> _getFirestoreUsers(
      AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
    documents.removeWhere((document) => document['email'] == UserDetails.email);
    return documents
        .map((document) => ListTile(
              leading: CircleAvatar(
                child: Image.network(document[
                    'imageUrl']), // no matter how big it is, it won't overflow
              ),
              title: Text(document['name']),
              subtitle: const Text(
                  "Pet Care Streak: 12🔥\nCurrently walking their pet"),
              onTap: () {
                Friend friend = Friend(
                  email: document['email'],
                  imageUrl: document['imageUrl'],
                  name: document['name'],
                  points: document['points'],
                  streak: document['streak'],
                  token: document['token'],
                );
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => FriendsProfileScreen(friend: friend)));
              },
            ))
        .toList();
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
          title: Text('Friends List'),
          backgroundColor: PrimaryAccentColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return const Text('There are no other users.');
              return ListView(children: _getFirestoreUsers(snapshot, context));
            }),
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
