import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_pet/models/managers/pet_manager.dart';
import 'package:virtual_pet/screens/pet/create_pet_form_widget.dart';

class CreatePetFormState extends State<CreatePetForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  late String value;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _controller,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your virtual pet's new name";
              }
              return null;
            },
            onChanged: (value) {
              this.value = _controller.text.toString();
              print('[LOG] value: ' + this.value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating your pet')),
                  );
                  PetManager.createNewPet(value);
                }
              },
              child: const Text('Adopt Your Virtual Pet'),
            ),
          ),
        ],
      ),
    );
  }
}
