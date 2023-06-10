import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/screens/teacher/add_classes_summary.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/large_input.dart';
import 'package:pole_paris_app/widgets/teacher/add_picture_button.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/drawer.dart';
import 'package:pole_paris_app/widgets/teacher/select_picker.dart';

class AddClassesScreen extends StatefulWidget {
  final ValueChanged<int>? onPush;
  const AddClassesScreen({super.key, this.onPush});

  @override
  State<AddClassesScreen> createState() => _AddClassesScreenState();
}

class _AddClassesScreenState extends State<AddClassesScreen> {
  static TextStyle inputLabels = const TextStyle(
    color: CustomColors.inputText,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Satoshi',
  );

  final List<String> hours = [
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
  ];

  XFile? _image;
  dynamic _pickImageError;

  bool _badName = false;
  DateTime _focusedDay = DateTime.now();

  final ImagePicker _picker = ImagePicker();
  final nameController = TextEditingController();
  final descController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _image = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Dodawanie zajęć',
        appBar: AppBar(),
      ),
      drawer: const TeacherDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 30.0,
                  left: 30.0,
                ),
                child: Column(
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
                          Calendar(
                            firstDay: DateTime.now(),
                            onDateChanged:
                                (DateTime selectedDay, DateTime focusedDay) {
                              if (_focusedDay.isSameDate(selectedDay) ==
                                  false) {
                                setState(() {
                                  _focusedDay = selectedDay;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Wybrana data',
                          style: TextStyle(
                            color: CustomColors.inputText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                        Text(
                          DateFormat('dd.MM.yyyy').format(_focusedDay),
                          style: const TextStyle(
                            color: CustomColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    Text(
                      'Wybierz godzinę',
                      style: inputLabels,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'od',
                          style: TextStyle(
                            color: CustomColors.hintText,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SelectPicker(
                          items: hours,
                          selectWidth: 110,
                          dropDownWidth: 110,
                          onChanged: (value) {},
                        ),
                        const Text(
                          'do',
                          style: TextStyle(
                            color: CustomColors.hintText,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SelectPicker(
                          items: hours,
                          selectWidth: 110,
                          dropDownWidth: 110,
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Wybierz poziom',
                        style: inputLabels,
                      ),
                    ),
                    SelectPicker(
                      items: Levels.values.map((e) => e.description).toList(),
                      selectWidth: double.infinity,
                      dropDownWidth: 160,
                      onChanged: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Wprowadź opis',
                        style: inputLabels,
                      ),
                    ),
                    LargeInput(
                      controller: descController,
                      hint: 'Opis zajęć...',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 10,
                      ),
                      child: Text(
                        'Dodaj zdjęcie',
                        style: inputLabels,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _image == null
                          ? [
                              AddPictureButton(
                                onPressed: () async =>
                                    await _onImageButtonPressed(
                                        ImageSource.gallery,
                                        context: context),
                                icon: Icons.insert_photo_outlined,
                                label: 'Wybierz z biblioteki',
                              ),
                              AddPictureButton(
                                onPressed: () async =>
                                    await _onImageButtonPressed(
                                        ImageSource.camera,
                                        context: context),
                                icon: Icons.camera_alt_outlined,
                                label: 'Zrób zdjęcie',
                              ),
                            ]
                          : [
                              _pickImageError != null
                                  ? Center(
                                      child: Text(
                                          'Błąd wyboru obrazka: $_pickImageError'))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(File(_image!.path),
                                          width: 120,
                                          height: 120,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Center(
                                                  child: Text(
                                                      'Nieprawidłowe zdjęcie'))),
                                    ),
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  style: changePictureStyle,
                                  child: const Text('ZMIEŃ'),
                                ),
                              )
                            ],
                    ),
                    const Divider(
                      height: 30,
                      color: Color(0xFFE1E1E1),
                      thickness: 1,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddClassSummary()),
                        );
                      },
                      style: CustomButtonStyle.primary,
                      child: const Text('DALEJ'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ButtonStyle changePictureStyle = ButtonStyle(
  elevation: const MaterialStatePropertyAll<double>(2),
  foregroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return CustomColors.text2;
      }
      return CustomColors.text;
    },
  ),
  overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
  backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
  surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
  shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24.0),
  )),
  textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Satoshi',
  )),
);
