import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/screens/create/image_banner.dart';
import 'package:petmo/screens/create/pet_create_screen.dart';
import 'package:petmo/screens/friends/friends_list_screen.dart';
import 'package:petmo/screens/profile/profile_screen.dart';
import 'package:petmo/widgets/bottom_nav_widget.dart';

import '../style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Pet pet;
  bool isLoading = false;
  bool doesLocalPetExist = false;

  @override
  void initState() {
    super.initState();
    refreshPet();
  }

  @override
  void dispose() {
    PetsDatabase.instance.close();
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
          body: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : !doesLocalPetExist
                      ? const PetCreateScreen()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Expanded(
                                child: buildAppBar(),
                              ),
                              // Expanded(
                              //   child: buildPet(pet),
                              // ),
                              const Center(
                                child: ImageBanner(
                                    'assets/images/kangaroo_idle_clear.gif'),
                              ),
                              const Expanded(
                                child: BottomNavWidget(),
                              )
                              // buildBottomNav(),
                            ]))));

  Widget buildAppBar() => Scaffold(
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const FriendsScreen()));
                    },
                    backgroundColor: PrimaryAccentColor,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.supervisor_account),
                  )),
              buildPetName(pet),
              Container(
                  margin: const EdgeInsets.only(right: 30.0, top: 5.0),
                  child: SpeedDial(
                      icon: Icons.menu,
                      activeIcon: Icons.close,
                      backgroundColor: PrimaryAccentColor,
                      foregroundColor: Colors.white,
                      activeBackgroundColor: Colors.white,
                      activeForegroundColor: PrimaryAccentColor,
                      buttonSize: 56.0,
                      visible: true,
                      direction: SpeedDialDirection.down,
                      curve: Curves.easeInCubic,
                      overlayColor: LightAccentColor,
                      overlayOpacity: 0.5,
                      elevation: 5.0,
                      shape: CircleBorder(),
                      children: [
                        SpeedDialChild(
                            child: const Icon(Icons.person),
                            backgroundColor: Colors.white,
                            foregroundColor: PrimaryAccentColor,
                            label: 'Profile',
                            labelBackgroundColor: Colors.white,
                            labelStyle: Body1TextStyle,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ProfileScreen()));
                            }),
                        SpeedDialChild(
                          child: const Icon(Icons.settings),
                          backgroundColor: Colors.white,
                          foregroundColor: PrimaryAccentColor,
                          label: 'Settings',
                          labelBackgroundColor: Colors.white,
                          labelStyle: Body1TextStyle,
                        )
                      ]))
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      );

  Future refreshPet() async {
    setState(() => isLoading = true);
    if (await PetsDatabase.instance.doesLocalPetExist()) {
      doesLocalPetExist = true;
      pet = await PetsDatabase.instance.getLocalPet();
    }
    setState(() => isLoading = false);
  }

  Widget buildPetName(Pet pet) => Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        pet.name,
        style: TitleTextStyle,
        textAlign: TextAlign.center,
      ));
}
