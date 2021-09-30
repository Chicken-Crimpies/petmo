import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_pet/db/pets_database.dart';
import 'package:virtual_pet/models/pet/pet_db_object.dart';
import 'package:virtual_pet/screens/pet/pet_create_screen.dart';

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
          title: const Text(
            'Petmo',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : !doesLocalPetExist
                  ? const PetCreateScreen()
                  : buildPet(pet),
        ),
      );

  Widget buildPet(Pet pet) => Scaffold(
        body: ListView(
          children: pet.attributes
              .map((attribute) => ListView(
                    children: [
                      Text(attribute.name),
                      Text(attribute.current.toString()),
                    ],
                  ))
              .toList(),
        ),
      );
}
//   Pet pet;
//
//   PetScreen(this.pet, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("VirtualPet"),
//       ),
//       body: ListView(
//         children: pet.attributes
//             .map((attribute) => ListView(
//                   children: [
//                     Text(attribute.name),
//                     Text(attribute.current.toString()),
//                   ],
//                 ))
//             .toList(),
//       ),
//       backgroundColor: Color(0xffBEE6CE),
//     );
//   }
// }
