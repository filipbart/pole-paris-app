import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/screens/teacher/classes_list.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/class_item.dart';
import 'package:pole_paris_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class MainScreenStudent extends StatefulWidget {
  const MainScreenStudent({super.key});

  @override
  State<MainScreenStudent> createState() => _MainScreenStudentState();
}

class _MainScreenStudentState extends State<MainScreenStudent> {
  late Map<String, List<Class>>? mappedClasses;
  static List<Class> classes = [
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now(),
      hourSince: '09:30',
      hourTo: '10:30',
      level: Level.primary,
      description: 'Jakiś tam opis',
      teacher: 'Magdalena',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now().add(const Duration(days: 1)),
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.advanced,
      description: 'Jakiś tam opis',
      teacher: 'Anna',
    ),
  ];

  late List<DrawerListTileItem> drawerItems = [
    DrawerListTileItem('Zapisz się na zajęcia', () {
      Navigator.pop(context);
      Provider.of<TabIndex>(context, listen: false).changeIndex(3);
    }),
    DrawerListTileItem('Wykup karnet', () {}),
    DrawerListTileItem('Twoje zajęcia', () {}),
    DrawerListTileItem('Profil', () {
      Navigator.pop(context);
      Provider.of<TabIndex>(context, listen: false).changeIndex(2);
    }),
    DrawerListTileItem('O nas', () {}),
    DrawerListTileItem('Kontakt', () {}),
    DrawerListTileItem('Ustawienia', () {}),
  ];

  static List<DateTime> days = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  void initState() {
    classes.sortBy((element) => element.date);
    mappedClasses =
        groupBy(classes, (p0) => DateFormat('dd.MM.yyyy').format(p0.date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/img/logo.png'), context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      drawer: BaseDrawer(
        drawerListTileItems: drawerItems,
      ),
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
                    'Witaj ponownie\nAleksandra!',
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
                      child: const Text('ZAPISZ SIĘ NA ZAJĘCIA'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nadchodzące zajęcia',
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Wrap(
                        runSpacing: 10,
                        children: [
                          ..._upcomingClasses(mappedClasses!.entries.first.key,
                              mappedClasses!.entries.first.value),
                          if (mappedClasses!.entries.first.value.length == 1)
                            ..._upcomingClasses(mappedClasses!.entries.last.key,
                                mappedClasses!.entries.last.value),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 15,
                                left: 15,
                              ),
                              child: ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ClassesScreenTeacher(),
                                    )),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Twoje karnety',
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Wrap(
                        runSpacing: 10,
                        children: [
                          Text('TODO'),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                right: 15,
                                left: 15,
                              ),
                              child: ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ClassesScreenTeacher(),
                                    )),
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
                      padding: EdgeInsets.only(left: 15.0),
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

  List<Widget> _upcomingClasses(String date, List<Class> classes) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Text(
          date,
          style: const TextStyle(
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
        child: ClassItem(classItem: classes.first, forStudent: true),
      ),
      if (classes.length != 1)
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE1E1E1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClassItem(classItem: classes.last, forStudent: true),
        ),
    ];
  }
}