import 'package:flutter/material.dart';
import 'package:virtual_pet/screens/pet/pet_screen.dart';

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
        // case HomeScreenRoute:
        //   if (petManager.isPetSet) {
        //     print('[LOG] running init pet screen');
        //     Pet pet = petManager.pet;
        //     // Route to home screen
        //     screen = PetScreen(pet);
        //   } else {
        //     print('[LOG] running init create');
        //     screen = CreatePetScreen();
        //   }
        //   break;
        // case CreatePetScreenRoute:
        //   screen = CreatePetScreen();
        //   break;
        // case LocationDetailRoute:
        //   final arguments = settings.arguments as Map<String, dynamic>;
        //   screen = LocationDetail(arguments['id']);
        //   break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff274C77),
          foregroundColor: Color(0xffA3CEF1),
          textTheme: TextTheme(headline1: AppBarTextStyle),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: const Color(0xff274C77),
          onPrimary: const Color(0xffA3CEF1),
        )),
        textTheme: TextTheme(
          headline1: TitleTextStyle,
          bodyText1: Body1TextStyle,
        ));
  }
}
