import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/screens/create/pet_create_screen.dart';
import 'package:petmo/screens/pet/pet_detail_screen.dart';
import 'package:petmo/widgets/bottom_nav_widget.dart';
import 'package:petmo/widgets/speed_dial_nav_widget.dart';

import '../style.dart';

class PetScreen extends StatefulWidget {
  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Petmo',
            textAlign: TextAlign.center,
            style: AppBarTextStyle,
          ),
        ),
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
                            child: buildPet(pet),
                          ),
                          Expanded(
                            child: BottomNavWidget(pet: pet),
                          ),
                          // buildBottomNav(),
                        ]),
        ),
      );

  Future refreshPet() async {
    setState(() => isLoading = true);
    if (await PetsDatabase.instance.doesLocalPetExist()) {
      doesLocalPetExist = true;
      pet = await PetsDatabase.instance.getLocalPet();
    }
    setState(() => isLoading = false);
  }

  Widget buildPet(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                pet.name,
                style: TitleTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Created: ' + DateFormat.yMMMd().format(pet.created),
              ),
              SizedBox(height: 20),
              Text('Attributes'),
              SizedBox(height: 8),
              Text(
                'Exercise: ' +
                    pet.getAttributeCurrentByKey('exercise').toString() +
                    ' / 100',
              ),
              SizedBox(height: 8),
              Text(
                'Happiness: ' +
                    pet.getAttributeCurrentByKey('happiness').toString() +
                    ' / 100',
              ),
              SizedBox(height: 8),
              Text(
                'Health: ' +
                    pet.getAttributeCurrentByKey('health').toString() +
                    ' / 100',
              ),
              SizedBox(height: 8),
              Text(
                'Hunger: ' +
                    pet.getAttributeCurrentByKey('hunger').toString() +
                    ' / 100',
              ),
            ]),
      );
}
