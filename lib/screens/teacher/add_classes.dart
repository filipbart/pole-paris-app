import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/input.dart';

class AddClassesScreen extends StatefulWidget {
  const AddClassesScreen({super.key});

  @override
  State<AddClassesScreen> createState() => _AddClassesScreenState();
}

class _AddClassesScreenState extends State<AddClassesScreen> {
  static TextStyle inputLabels = const TextStyle(
    color: CustomColors.inputText,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Satoshi',
  );

  bool _badName = false;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 10,
            children: [
              Text(
                'Nazwa zajęć',
                style: inputLabels,
              ),
              Input(
                controller: nameController,
                hint: 'Wprowadź nazwę',
                inputType: TextInputType.emailAddress,
                onChanged: (text) {
                  setState(() {
                    _badName = text.isEmpty;
                  });
                },
                errorText: _badName ? 'Wprowadź nazwę!' : null,
                withBorder: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Wrap(
              runSpacing: 10,
              children: [
                Text(
                  'Wybierz datę',
                  style: inputLabels,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
