import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmo/db/pets_database.dart';
import 'package:petmo/models/attributes/abstract_pet_attribute.dart';
import 'package:petmo/models/pet/pet.dart';
import 'package:petmo/screens/create/image_banner.dart';
import 'package:petmo/widgets/pet_create_form_widget.dart';
import 'package:slide_button/slide_button.dart';

import '../petmo.dart';
import '../style.dart';

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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: createPet,
      //   child: Icon(Icons.add),
      //   tooltip: 'Create',
      //   backgroundColor: isFormValid ? PrimaryAccentColor : DarkAccentColor,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageBanner('assets/images/logo.jpg'),
            SizedBox(height: 20),
            const Text(
              'Create Your Pet',
              style: TitleTextStyle,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: PetCreateFormWidget(
                name: name,
                onChangedName: (name) => setState(() => this.name = name),
              ),
            ),
            buildSlider(isFormValid),
          ],
        ),
      ),
    );
  }

  Widget buildSlider(bool isFormValid) => SlideButton(
        height: 64,
        slidingChild: Align(
          alignment: Alignment.centerRight,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.chevron_right)),
        ),
        slidingBarColor: isFormValid ? PrimaryAccentColor : DarkAccentColor,
        slideDirection: SlideDirection.RIGHT,
        isDraggable: isFormValid,
        onButtonSlide: (position) => position > 0.99 ? createPet() : false,
      );
}
