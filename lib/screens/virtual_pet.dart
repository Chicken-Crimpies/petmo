import 'package:flutter/material.dart';
import 'package:virtual_pet/screens/pet/create_pet_screen.dart';

import 'style.dart';

const CreatePetRoute ='/';

class VirtualPet extends StatelessWidget {
  const VirtualPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: _routes(), theme: _theme());
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen;
      switch (settings.name) {
        case CreatePetRoute:
          screen = CreatePetScreen();
          break;
        // case LocationDetailRoute:
        //   final arguments = settings.arguments as Map<String, dynamic>;
        //   screen = LocationDetail(arguments['id']);
        //   break;
        default:
          return null;
      }
      // return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          textTheme: TextTheme(headline1: AppBarTextStyle),
        ),
        textTheme: TextTheme(
          headline1: TitleTextStyle,
          bodyText1: Body1TextStyle,
        ));
  }
}