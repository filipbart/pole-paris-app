import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';

import 'package:pole_paris_app/widgets/teacher/class_item.dart';
import 'package:provider/provider.dart';

class ClassesListScreen extends StatefulWidget {
  final bool forStudent;
  const ClassesListScreen({super.key, required this.forStudent});

  @override
  State<ClassesListScreen> createState() => _ClassesListScreenState();
}

class _ClassesListScreenState extends State<ClassesListScreen> {
  static List<Class> classes = [
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now(),
      hourSince: '09:30',
      hourTo: '10:30',
      level: Level.primary,
      description: 'Jakiś tam opis',
      teacher: 'Anna',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now(),
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.intermediate,
      description: 'Jakiś tam opis',
      teacher: 'Magdalena',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now().add(const Duration(days: 1)),
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.intermediate,
      description: 'Jakiś tam opis',
      teacher: 'Magdalena',
    ),
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now().add(const Duration(days: 1)),
      hourSince: '16:30',
      hourTo: '17:30',
      level: Level.all,
      description: 'Jakiś tam opis',
      teacher: 'Anna',
    ),
  ];

  final dates =
      groupBy(classes, (p0) => DateFormat('dd.MM.yyyy').format(p0.date));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title:
            widget.forStudent ? 'Twoje zajęcia' : 'Zajęcia, które prowadzisz',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: Column(
              children: [
                if (widget.forStudent)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Czas wypisania z zajęć to 10 godzin przed zajęciami, w przypadku późniejszego wypisania zajęcia przepadają.',
                      style: TextStyle(
                        color: CustomColors.hintText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ...dates.entries
                    .map((dateClass) =>
                        titleWithClassList(dateClass.key, dateClass.value))
                    .toList(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text('Nie masz więcej zajęć.'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<TabIndex>(context, listen: false)
                                .changeIndex(3);
                          },
                          style: CustomButtonStyle.primary,
                          child: Text(widget.forStudent
                              ? 'ZAPISZ SIĘ NA ZAJĘCIA'
                              : 'DODAJ NOWE ZAJĘCIA'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWithClassList(String date, List<Class> classes) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Divider(
                color: Color(0xFF838383),
                height: 20,
                thickness: 0.5,
              ),
            ),
            ...classes
                .map((classItem) => Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ClassItem(
                          classItem: classItem, forStudent: widget.forStudent),
                    ))
                .toList(),
          ],
        ),
      );
}
