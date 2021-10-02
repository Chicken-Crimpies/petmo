import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/screens/style.dart';
import 'package:slide_button/slide_button.dart';

class PetCreateFormWidget extends StatelessWidget {
  final String? name;
  final ValueChanged<String> onChangedName;

  const PetCreateFormWidget({
    Key? key,
    this.name = '',
    required this.onChangedName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: SecondaryAccentColor,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        cursorColor: SecondaryAccentColor,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SecondaryAccentColor),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DarkAccentColor),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          labelText: 'Enter A Name',
          labelStyle: TextStyle(
            color: SecondaryAccentColor,
          ),
          floatingLabelStyle: TextStyle(
            color: SecondaryAccentColor,
          ),
          prefixIcon: Icon(Icons.animation),
          prefixStyle: TextStyle(
            color: SecondaryAccentColor,
          ),
        ),
        validator: (name) => name != null && name.isEmpty
            ? 'The name cannot be empty'
            : null,
        onChanged: onChangedName,
      );
}
