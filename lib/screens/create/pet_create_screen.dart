import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/attributes/abstract_pet_attribute.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/widgets/pet_create_form_widget.dart';

import '../petmo.dart';

class PetCreateScreen extends StatefulWidget {
  final Pet? pet;

  const PetCreateScreen({
    Key? key,
    this.pet,
  }) : super(key: key);

  @override
  _PetCreateScreenState createState() => _PetCreateScreenState();
}

class _PetCreateScreenState extends State<PetCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  bool isCreating = false;

  @override
  void initState() {
    super.initState();
    name = widget.pet?.name ?? '';
  }

  @override
  void dispose() {
    PetsDatabase.instance.close();
    super.dispose();
  }

  Future createPet() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    setState(() => isCreating = true);
    final pet = Pet(
      name: name,
      created: DateTime.now(),
      attributes: PetAttribute.createDefaultAttributes(),
      isLocalPet: true,
    );
    await PetsDatabase.instance.create(pet);
    setState(() => isCreating = false);
    Navigator.pushNamed(context, PetScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid = name.isNotEmpty;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: createPet,
        child: Icon(Icons.add),
        tooltip: 'Create',
        backgroundColor: isFormValid ? const Color(0xff274C77) : const Color(0xff8B8C89),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Form(
        key: _formKey,
        child: PetCreateFormWidget(
          name: name,
          onChangedName: (name) => setState(() => this.name = name),
        ),
      ),
    );
  }

  // Widget buildCreateButton() {
  //   final isFormValid = name.isNotEmpty;
  //
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         onPrimary: Colors.white,
  //         primary: isFormValid ? null : Colors.grey.shade700,
  //       ),
  //       onPressed: createPet,
  //       child: Text('Create'),
  //     ),
  //   );
  // }
}
