import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:petmo/screens/pet/pet_detail_screen.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import 'style.dart';

const PetScreenRoute = '/';
const PetDetailScreenRoute = '/pet_detail';

class Petmo extends StatelessWidget {
  const Petmo({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: _routes(), theme: _theme(), navigatorObservers: <NavigatorObserver>[observer]);
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen;
      switch (settings.name) {
        case PetScreenRoute:
          screen = PetScreen();
          break;
        case PetDetailScreenRoute:
          final arguments = settings.arguments as Map<String, dynamic>;
          screen = PetDetailScreen(pet: arguments['pet']);
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
