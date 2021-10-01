import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      color: Color(0xff6097BA),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    cursorColor: Color(0xff6097BA),
    decoration: const InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff6097BA)),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff8B8C89)),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      labelText: 'Enter A Pet Name',
      labelStyle: TextStyle(
        color: Color(0xff6097BA),
      ),
      floatingLabelStyle: TextStyle(
        color: Color(0xff6097BA),
      ),
      prefixIcon: Icon(Icons.animation),
      prefixStyle: TextStyle(
        color: Color(0xff6097BA),
      )
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'The pet name cannot be empty' : null,
    onChanged: onChangedName,
  );
}
