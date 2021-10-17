import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:petmo/models/user/user_details.dart';
import 'package:petmo/screens/create/image_banner.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import '../style.dart';

class FacebookLoginScreen extends StatefulWidget {
  const FacebookLoginScreen({Key? key}) : super(key: key);

  @override
  _FacebookLoginScreenState createState() => _FacebookLoginScreenState();
}

class _FacebookLoginScreenState extends State<FacebookLoginScreen> {
  bool loading = false;

  void _loginWithFacebook() async {
    setState(() {
      loading = true;
    });

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
      });

      UserDetails.name = userData['name'];
      UserDetails.email = userData['email'];
      UserDetails.profilePictureUrl = userData['picture']['data']['url'];

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => PetScreen()), (route) => false);
    } on FirebaseAuthException catch (exception) {
      String content = '';
      switch (exception.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'The user you tried to log into was not found';
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with facebook failed'),
                content: Text(content),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [SecondaryAccentColor, LightAccentColor])),
          child: Scaffold(
          body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            const ImageBanner('assets/images/logo_clear.jpg'),
            !loading
                ? Column(children: [
                    const SizedBox(height: 20),
                    const Text('Connect With Facebook', style: Body1TextStyle),
                    const SizedBox(height: 15),
                    Center(
                        child: GestureDetector(
                            onTap: _loginWithFacebook,
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
                                  child: Icon(Icons.facebook),
                                ))))
                  ])
                : const CircularProgressIndicator(),
          ]))));
}
