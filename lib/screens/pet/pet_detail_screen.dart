import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmo/models/pet/pet.dart';

import '../style.dart';

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailScreenState createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
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
      body: ListView(
              children: [
                buildName(widget.pet),
                buildCreated(widget.pet),
                buildRating(widget.pet),
              ],
            ));

  Widget buildName(Pet pet) => Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          pet.name,
          style: TitleTextStyle,
          textAlign: TextAlign.center,
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
