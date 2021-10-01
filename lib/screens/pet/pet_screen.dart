import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/screens/create/pet_create_screen.dart';

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

  Future refreshPet() async {
    setState(() => isLoading = true);
    if (await PetsDatabase.instance.doesLocalPetExist()) {
      doesLocalPetExist = true;
      pet = await PetsDatabase.instance.getLocalPet();
    }
    setState(() => isLoading = false);
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
          // actions: [
          //   Icon(Icons.airline_seat_legroom_reduced_sharp),
          //   SizedBox(width: 12)
          // ],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : !doesLocalPetExist
                  ? const PetCreateScreen()
                  : buildPet(pet),
        ),
      );

  Widget buildPet(Pet pet) => Padding(
        padding: EdgeInsets.all(12),
        child: ListView(padding: EdgeInsets.symmetric(vertical: 8), children: [
          Text(
            pet.name,
          ),
          SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(pet.created),
          ),
          SizedBox(height: 8),
          Text(
            pet.getAttributeCurrentByKey('exercise').toString(),
          ),
          SizedBox(height: 8),
          Text(
            pet.getAttributeCurrentByKey('happiness').toString(),
          ),          SizedBox(height: 8),
          Text(
            pet.getAttributeCurrentByKey('health').toString(),
          ),          SizedBox(height: 8),
          Text(
            pet.getAttributeCurrentByKey('hunger').toString(),
          ),
        ]),
      );
}
