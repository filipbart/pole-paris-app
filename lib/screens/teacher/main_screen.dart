import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/classes_item.dart';

class MainScreenTeacher extends StatefulWidget {
  const MainScreenTeacher({super.key});

  @override
  State<MainScreenTeacher> createState() => _MainScreenTeacherState();
}

class _MainScreenTeacherState extends State<MainScreenTeacher> {
  static List<DateTime> days = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Logo(
                  width: 180,
                ),
                const Text(
                  'Cześć\nMagdalena!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: CustomColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 30.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: CustomButtonStyle.primary,
                    child: const Text('DODAJ ZAJĘCIA'),
                  ),
                ),
                const Text(
                  'Nadchodzące zajęcia, które prowadzisz',
                  style: TextStyle(
                    color: CustomColors.buttonAdditional,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Color(0xFFD6D6D6),
                  thickness: 1.2,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '16.05.2023',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE1E1E1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const ClassesItem(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '17.05.2023',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE1E1E1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const ClassesItem(),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              right: 15,
                              left: 15,
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: CustomButtonStyle.seeMore,
                              child: const Text(
                                'ZOBACZ WIĘCEJ',
                                style: TextStyle(
                                  color: Color(0xFF222227),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Dzisiejsza data',
                      style: TextStyle(
                        color: CustomColors.buttonAdditional,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xFFD6D6D6),
                  thickness: 1.2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 10,
                    right: 10,
                    bottom: 60,
                  ),
                  child: Calendar(
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    classDays: days,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: CustomButtonStyle.secondary,
                    child: const Text('WYLOGUJ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
