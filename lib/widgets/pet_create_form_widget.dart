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
          buildTitle(),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: name,
    style: const TextStyle(
      color: Color(0xffA3CEF1),
      backgroundColor: Color(0xff8B8C89),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Name',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The name cannot be empty' : null,
    onChanged: onChangedName,
  );
}
