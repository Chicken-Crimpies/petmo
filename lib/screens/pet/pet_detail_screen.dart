import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/widgets/bottom_nav_widget.dart';

import '../style.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailScreenState createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    name = widget.pet.name;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Petmo',
            textAlign: TextAlign.center,
            style: AppBarTextStyle,
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(children: [
                  buildName(widget.pet),
                  buildCreated(widget.pet),
                  buildAge(widget.pet),
                  buildRating(widget.pet),
                ]),
              ),
              Expanded(
                child: BottomNavWidget(pet: widget.pet),
              ),
              // buildBottomNav(),
            ]),
      );

  Widget buildName(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: TextFormField(
          maxLines: 1,
          initialValue: name,
          style: const TextStyle(
            color: SecondaryAccentColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          cursorColor: SecondaryAccentColor,
          decoration: const InputDecoration(

            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: SecondaryAccentColor),
            //   borderRadius: BorderRadius.all(Radius.circular(15)),
            // ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DarkAccentColor),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // labelText: 'Enter A Name',
            // labelStyle: TextStyle(
            //   color: SecondaryAccentColor,
            // ),
            floatingLabelStyle: TextStyle(
              color: SecondaryAccentColor,
            ),
            suffixIcon: Icon(Icons.edit, color: DarkAccentColor),
            suffixStyle: TitleTextStyle,
          ),
          validator: (name) =>
              name != null && name.isEmpty ? 'The name cannot be empty' : null,
          // onChanged: onChangedName,
        ),
      );

  Widget buildCreated(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Created: ' + DateFormat.yMMMd().format(pet.created),
          style: Body1TextStyle,
          textAlign: TextAlign.center,
        ),
      );

  Widget buildAge(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Age (Days): ' +
              DateTime.now().difference(pet.created).inDays.toString(),
          style: Body1TextStyle,
          textAlign: TextAlign.center,
        ),
      );

  Widget buildRating(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Rating: ',
          style: Body1TextStyle,
          textAlign: TextAlign.center,
        ),
      );

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
}
