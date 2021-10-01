import 'package:flutter/material.dart';
import 'package:petmo/screens/pet/pet_screen.dart';

import 'style.dart';

const PetScreenRoute = '/';

class Petmo extends StatelessWidget {
  const Petmo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: _routes(), theme: _theme());
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen;
      switch (settings.name) {
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
