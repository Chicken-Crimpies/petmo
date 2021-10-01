import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/screens/create/pet_create_screen.dart';

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
            style: TextStyle(fontSize: 24),
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
                            child: buildBottomNav(),
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

  Widget buildBottomNav() => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: SecondaryAccentColor,
          onPressed: () {},
          child: Icon(Icons.adjust),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
            color: PrimaryAccentColor,
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.scatter_plot_outlined,
                    color: LightAccentColor,
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(right: 90),
                  child: IconButton(
                    icon: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )),
      );
}
