import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/screens/teacher/class_students.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

TextStyle dataStyle = const TextStyle(
  color: Color(0xFF404040),
  fontFamily: 'Satoshi',
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

class ClassDetailsTeacherScreen extends StatelessWidget {
  final Class classDetails;
  const ClassDetailsTeacherScreen({
    super.key,
    required this.classDetails,
  });

  static ButtonStyle _buttonStyle(bool withSize) => ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return CustomColors.text2;
            }
            return CustomColors.hintText;
          },
        ),
        overlayColor:
            const MaterialStatePropertyAll<Color>(CustomColors.background),
        backgroundColor:
            const MaterialStatePropertyAll<Color>(CustomColors.background),
        surfaceTintColor:
            const MaterialStatePropertyAll<Color>(CustomColors.background),
        shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        )),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const BorderSide(
                width: 1.0,
                color: CustomColors.text2,
              );
            }
            return const BorderSide(
              width: 1.0,
              color: CustomColors.hintText,
            );
          },
        ),
        textStyle: const MaterialStatePropertyAll<TextStyle>(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Satoshi',
          ),
        ),
        minimumSize: MaterialStatePropertyAll<Size?>(
          withSize ? const Size.fromHeight(50) : null,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Szczegóły zajęć',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(color: Color(0xFFE1E1E1))),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClassBaseInfo(classDetails: classDetails),
                      ElevatedButton(
                          onPressed: () {},
                          style: _buttonStyle(false),
                          child: const Text('EDYTUJ')),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.group_outlined,
                                            color: CustomColors.inputText,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: CustomColors.inputText,
                                              fontFamily: 'Satoshi',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'x/${classDetails.places}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const TextSpan(text: ' miejsc'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.place_outlined,
                                            color: CustomColors.inputText,
                                          ),
                                        ),
                                        Text(
                                          classDetails.name
                                                  .toLowerCase()
                                                  .contains("pole")
                                              ? 'Pole Room'
                                              : 'Stretching & Fitness Room',
                                          style: dataStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                'Opis zajęć',
                                style: TextStyle(
                                  color: CustomColors.inputText,
                                  fontFamily: 'Satoshi',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 20),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      classDetails.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Wrap(
                          runSpacing: 15,
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ClassStudentsScreen(
                                                classDetails: classDetails))),
                                style: _buttonStyle(true),
                                child: const Text('LISTA KURSANTÓW')),
                            ElevatedButton(
                              onPressed: () {},
                              style: _buttonStyle(true),
                              child: const Text('ZAPISZ SAMODZIELNIE'),
                            ),
                            const Divider(
                              color: Color(0xFF838383),
                              thickness: 0.5,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: CustomButtonStyle.primary,
                                child: const Text('ODWOŁAJ ZAJĘCIA')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
