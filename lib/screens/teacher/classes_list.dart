import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/teacher/class_item.dart';
import 'package:provider/provider.dart';

class ClassesScreenTeacher extends StatefulWidget {
  const ClassesScreenTeacher({super.key});

  @override
  State<ClassesScreenTeacher> createState() => _ClassesScreenTeacherState();
}

class _ClassesScreenTeacherState extends State<ClassesScreenTeacher> {
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
    Class(
      name: 'HIGH HEELS',
      date: DateTime.now().add(const Duration(days: 1)),
      hourSince: '16:30',
      hourTo: '17:30',
      level: Level.advanced,
      description: 'Jakiś tam opis',
    ),
  ];

  final dates =
      groupBy(classes, (p0) => DateFormat('dd.MM.yyyy').format(p0.date));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Zajęcia, które prowadzisz',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                          child: const Text('DODAJ NOWE ZAJĘCIA'),
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
                      child: ClassItem(classItem: classItem),
                    ))
                .toList(),
          ],
        ),
      );
}
