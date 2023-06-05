import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/classes_item.dart';

class MainPageTeacher extends StatefulWidget {
  const MainPageTeacher({super.key});

  @override
  State<MainPageTeacher> createState() => _MainPageTeacherState();
}

class _MainPageTeacherState extends State<MainPageTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 20.0,
          right: 20.0,
          bottom: 20,
        ),
        child: SingleChildScrollView(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const ClassesItem(),
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
                      const ClassesItem(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            onPressed: () {},
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
              const Calendar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
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
      )),
    );
  }
}
