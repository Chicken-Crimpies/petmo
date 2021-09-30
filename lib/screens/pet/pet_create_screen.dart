import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_pet/db/pets_database.dart';
import 'package:virtual_pet/models/attributes/abstract_pet_attribute.dart';
import 'package:virtual_pet/models/pet/pet_db_object.dart';
import 'package:virtual_pet/widgets/pet_create_form_widget.dart';

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
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: PetCreateFormWidget(
            name: name,
            onChangedName: (name) => setState(() => this.name = name),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: createPet,
        child: Text('Create'),
      ),
    );
  }
}
