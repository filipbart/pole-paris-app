import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/classes_item.dart';
import 'package:pole_paris_app/widgets/teacher/drawer.dart';

class MainPageTeacher extends StatefulWidget {
  const MainPageTeacher({super.key});

  @override
  State<MainPageTeacher> createState() => _MainPageTeacherState();
}

class _MainPageTeacherState extends State<MainPageTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      drawer: const TeacherDrawer(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
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
              const Calendar(),
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
      )),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 119, 119, 119),
              blurRadius: 30,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedLabelStyle: const TextStyle(
            color: CustomColors.buttonAdditional,
            fontSize: 10,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
          ),
          selectedItemColor: CustomColors.text,
          selectedLabelStyle: const TextStyle(
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'strona główna',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_none_rounded,
              ),
              label: 'powiadomienia',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
              ),
              label: 'twój profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'dodaj zajęcia',
            ),
          ],
        ),
      ),
    );
  }
}
