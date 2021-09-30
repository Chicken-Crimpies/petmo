import 'package:flutter/material.dart';
import 'package:virtual_pet/screens/create/create_pet_form_widget.dart';

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
      backgroundColor: Color(0xffE7ECEF),
    );
  }
}
