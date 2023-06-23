import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/screens/teacher/add_class_summary.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/drawer.dart';

import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/large_input.dart';
import 'package:pole_paris_app/widgets/teacher/add_picture_button.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';

import 'package:pole_paris_app/widgets/select_picker.dart';
import 'package:provider/provider.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

TextStyle inputLabels = const TextStyle(
  color: CustomColors.inputText,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  fontFamily: 'Satoshi',
);

class _AddClassScreenState extends State<AddClassScreen> {
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

  late List<DrawerListTileItem> drawerItems = [
    DrawerListTileItem('Dodaj zajęcia', () {
      Navigator.pop(context);
      Provider.of<TabIndex>(context, listen: false).changeIndex(3);
    }),
    DrawerListTileItem('Twoje zajęcia', () {}),
    DrawerListTileItem('Profil instruktora', () {
      Navigator.pop(context);
      Provider.of<TabIndex>(context, listen: false).changeIndex(2);
    }),
    DrawerListTileItem('Ustawienia', () {}),
  ];

  XFile? _image;
  String? hourSince;
  String? hourTo;
  Level? level;
  dynamic _pickImageError;

  bool _badName = false;
  bool _badDesc = false;
  bool _nullSince = false;
  bool _nullTo = false;
  bool _nullLevel = false;
  bool _noImage = false;

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

  _submit() {
    final name = nameController.value.text;
    final desc = descController.value.text;
    final sinceIndex = hours.indexOf(hourSince ?? '');
    final toIndex = hours.indexOf(hourTo ?? '');

    setState(() {
      _badName = name.isEmpty;
      _badDesc = desc.isEmpty;
      _nullSince =
          hourSince == null || (sinceIndex > toIndex || sinceIndex == -1);
      _nullTo = hourTo == null || (sinceIndex > toIndex || toIndex == -1);
      _nullLevel = level == null;
      _noImage = _image == null;
    });

    // if (_badName ||
    //     _badDesc ||
    //     _nullSince ||
    //     _nullTo ||
    //     _nullLevel ||
    //     _noImage) {
    //   return;
    // }

    final newClass = Class(
      name: name,
      date: _focusedDay,
      hourSince: hourSince!,
      hourTo: hourTo!,
      level: level!,
      description: desc,
      teacher: 'Anna',
      image: _image!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddClassSummary(newClass: newClass)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Dodawanie zajęć',
        appBar: AppBar(),
      ),
      drawer: BaseDrawer(
        teacher: true,
        drawerListTileItems: drawerItems,
      ),
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
                          errorText: _badName
                              ? 'Nie podano nazwy. Wprowadź nazwę.'
                              : null,
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
                padding: const EdgeInsets.only(top: 10.0),
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
                          errorBorder: _nullSince,
                          onChanged: (value) {
                            setState(() {
                              hourSince = value;
                              _nullSince = false;
                            });
                          },
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
                          errorBorder: _nullTo,
                          onChanged: (value) {
                            setState(() {
                              hourTo = value;
                              _nullTo = false;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_nullSince || _nullTo)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          _nullSince
                              ? const Text(
                                  'Błędna godzina.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CustomColors.error,
                                    fontWeight: FontWeight.w700,
                                    height: 0.9,
                                  ),
                                )
                              : const SizedBox(width: 100),
                          const SizedBox(
                            width: 10,
                          ),
                          _nullTo
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    'Błędna godzina.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: CustomColors.error,
                                      fontWeight: FontWeight.w700,
                                      height: 0.9,
                                    ),
                                  ),
                                )
                              : const SizedBox(width: 104),
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
                      items: Level.values.map((e) => e.description).toList(),
                      selectWidth: double.infinity,
                      dropDownWidth: 160,
                      errorText: _nullLevel
                          ? 'Nie wybrano poziomu. Wybierz poziom.'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          level = LevelHelper.enumValueByDesc(value!);
                          _nullLevel = false;
                        });
                      },
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
                      errorText:
                          _badDesc ? 'Nie podano opisu. Wprowadź opis.' : null,
                      onChanged: (text) {
                        setState(() {
                          _badDesc = text.isEmpty;
                        });
                      },
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
                    Wrap(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _image == null
                            ? [
                                AddPictureButton(
                                  onPressed: () async {
                                    await _onImageButtonPressed(
                                        ImageSource.gallery,
                                        context: context);
                                    setState(() {
                                      _noImage = _image == null;
                                    });
                                  },
                                  icon: Icons.add_photo_alternate_outlined,
                                  label: 'Wybierz z biblioteki',
                                ),
                                AddPictureButton(
                                  onPressed: () async {
                                    await _onImageButtonPressed(
                                        ImageSource.camera,
                                        context: context);
                                    setState(() {
                                      _noImage = _image == null;
                                    });
                                  },
                                  icon: Icons.add_a_photo_outlined,
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
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 120,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Center(
                                                    child: Text(
                                                        'Nieprawidłowe zdjęcie'))),
                                      ),
                                SizedBox(
                                  width: 140,
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
                      if (_noImage)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: Text(
                              'Brak wybranego zdjęcia. Wybierz zdjecie.',
                              style: TextStyle(
                                fontSize: 12,
                                color: CustomColors.error,
                                fontWeight: FontWeight.w700,
                                height: 0.9,
                              ),
                            ),
                          ),
                        ),
                    ]),
                    const Divider(
                      height: 30,
                      color: Color(0xFFE1E1E1),
                      thickness: 1,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
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
