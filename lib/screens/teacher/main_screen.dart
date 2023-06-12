import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/class_item.dart';
import 'package:pole_paris_app/widgets/teacher/drawer.dart';
import 'package:provider/provider.dart';

class MainScreenTeacher extends StatefulWidget {
  const MainScreenTeacher({super.key});

  @override
  State<MainScreenTeacher> createState() => _MainScreenTeacherState();
}

class _MainScreenTeacherState extends State<MainScreenTeacher> {
  static List<Class> classes = [
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now(),
      hourSince: '09:30',
      hourTo: '10:30',
      level: Level.primary,
      description: 'Jakiś tam opis',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now(),
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.advanced,
      description: 'Jakiś tam opis',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now().add(const Duration(days: 1)),
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.advanced,
      description: 'Jakiś tam opis',
    ),
  ];

  static List<DateTime> days = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      drawer: const TeacherDrawer(),
      body: SafeArea(
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
                      onPressed: () {
                        Provider.of<TabIndex>(context, listen: false)
                            .changeIndex(3);
                      },
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
                              border:
                                  Border.all(color: const Color(0xFFE1E1E1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClassItem(classItem: classes[0]),
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
                              border:
                                  Border.all(color: const Color(0xFFE1E1E1)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClassItem(classItem: classes[1]),
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
                      firstDay:
                          DateTime.now().subtract(const Duration(days: 30)),
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
      ),
    );
  }
}
