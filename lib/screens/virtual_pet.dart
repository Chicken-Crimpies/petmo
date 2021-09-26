import 'package:flutter/material.dart';
import 'package:virtual_pet/models/db/db_handler.dart';
import 'package:virtual_pet/models/managers/pet_db_manager.dart';
import 'package:virtual_pet/models/managers/pet_manager.dart';
import 'package:virtual_pet/models/pet/pet.dart';
import 'package:virtual_pet/screens/pet/create_pet_screen.dart';

import 'style.dart';

const CreatePetRoute = '/';

class VirtualPet extends StatelessWidget {
  const VirtualPet({Key? key}) : super(key: key);

  static final petDBManager = PetDBManager();
  static final petManager = PetManager(List.empty(growable: true));

  @override
  Widget build(BuildContext context) {
    DBHandler.initDb();
    PetDBManager.retrievePets().then((value) {
      petManager.setAllPets(value);
      for (Pet pet in value) {
        if (pet.isLocalPet) {
          petManager.setLocalPet(pet);
          break;
        }
      }
      print('[LOG] Local pet: ' + petManager.pet.name);
    });
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
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffBEE6CE),
          foregroundColor: Color(0xff4F9D69),
          textTheme: TextTheme(headline1: AppBarTextStyle),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffBEE6CE),
              onPrimary: const Color(0xff4F9D69),
            )
        ),
        textTheme: TextTheme(
          headline1: TitleTextStyle,
          bodyText1: Body1TextStyle,
        ));
  }
}
