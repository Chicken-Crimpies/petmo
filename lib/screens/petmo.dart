import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import 'login/facebook_login_screen.dart';
import 'style.dart';

const LoginRoute = '/';
const PetScreenRoute = '/home';
const PetDetailScreenRoute = '/pet_detail';

class Petmo extends StatelessWidget {
  final _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return MaterialApp(
              onGenerateRoute: _routes(),
              theme: _theme(),
              home: const FacebookLoginScreen());
        });
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen;
      print(settings.name);
      switch (settings.name) {
        case LoginRoute:
          screen = const FacebookLoginScreen();
          break;
        case PetScreenRoute:
          screen = PetScreen();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
      fontFamily: DefaultFontFamily,
      scaffoldBackgroundColor: LightAccentColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: PrimaryAccentColor,
        foregroundColor: Colors.white,
        textTheme: TextTheme(headline1: AppBarTextStyle),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: PrimaryAccentColor,
        onPrimary: TertiaryAccentColor,
      )),
      textTheme: TextTheme(
        headline1: TitleTextStyle,
        bodyText1: Body1TextStyle,
      ),
      // backgroundColor: DarkAccentColor,
    );
  }
}
