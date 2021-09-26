import 'package:flutter/material.dart';
import 'package:virtual_pet/screens/pet/create_pet_form_widget.dart';

class CreatePetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VirtualPet'),
      ),
      body: const Center(
        child: CreatePetForm(),
      ),
    );
  }
}
