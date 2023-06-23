import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/date_select_picker.dart';
import 'package:pole_paris_app/widgets/select_picker.dart';
import 'package:pole_paris_app/widgets/student/available_class_item.dart';

class AvailableClassesList extends StatefulWidget {
  const AvailableClassesList({super.key});

  @override
  State<AvailableClassesList> createState() => _AvailableClassesListState();
}

class _AvailableClassesListState extends State<AvailableClassesList> {
  late List<Class> filteredList;
  static List<Class> classes = [
    Class(
      date: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 30),
      description: '',
      hourSince: '09:30',
      hourTo: '10:30',
      level: Level.primary,
      name: 'POLE DANCE',
      teacher: 'Magdalena',
    ),
    Class(
      date: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 10, 30),
      description: '',
      hourSince: '10:30',
      hourTo: '11:30',
      level: Level.all,
      name: 'STRETCHING',
      teacher: 'Anna',
    ),
    Class(
      date: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 21, 30),
      description: '',
      hourSince: '21:30',
      hourTo: '22:30',
      level: Level.all,
      name: 'FITNESS',
      teacher: 'Oliwia',
    ),
    Class(
      date: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 14, 30),
      description: '',
      hourSince: '14:30',
      hourTo: '15:30',
      level: Level.advanced,
      name: 'HIGH HEELS',
      teacher: 'Renata',
    ),
    Class(
      date: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 15, 30),
      description: '',
      hourSince: '15:30',
      hourTo: '16:30',
      level: Level.primary,
      name: 'POLE DANCE',
      teacher: 'Magdalena',
    ),
  ];

  _filterList() {
    print('filter');
    var tempFilteredList = classes;
    print(tempFilteredList);
    if (_date != null) {
      tempFilteredList = tempFilteredList
          .where((element) => element.date.isSameDate(_date!))
          .toList();
    }

    print(_level);
    if (_level != null && _level! != Level.all) {
      tempFilteredList =
          tempFilteredList.where((element) => element.level == _level).toList();
    }

    if (_teacher != null) {
      tempFilteredList = tempFilteredList
          .where((element) => element.teacher == _teacher)
          .toList();
    }

    if (_className != null) {
      tempFilteredList = tempFilteredList
          .where((element) =>
              element.name.toLowerCase() == _className!.toLowerCase())
          .toList();
    }

    setState(() {
      filteredList = tempFilteredList;
    });
  }

  late List<String> teachers;
  late List<String> levels;

  DateTime? _date;
  Level? _level;
  String? _teacher;
  String? _className;

  @override
  void initState() {
    super.initState();
    filteredList = classes;
    var tempLevels = Level.values.map((e) => e.description).toList();
    tempLevels.insert(0, 'Wybierz...');
    levels = tempLevels;

    var tempTeachers =
        groupBy(classes, (p0) => p0.teacher).entries.map((e) => e.key).toList();
    tempTeachers.insert(0, 'Wybierz...');
    teachers = tempTeachers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Dostępne zajęcia',
        appBar: AppBar(),
        withDrawer: false,
      ),
      drawer: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction: Axis.horizontal,
                        spacing: 15,
                        runSpacing: 10,
                        children: [
                          DateSelectPicker(
                            selectWidth:
                                MediaQuery.of(context).size.width * 0.42,
                            callback: (date) {
                              setState(() {
                                _date = date;
                              });
                              _filterList();
                            },
                          ),
                          SelectPicker(
                            items: levels,
                            selectWidth:
                                MediaQuery.of(context).size.width * 0.42,
                            dropDownWidth: 160,
                            hintText: 'Wybierz poziom',
                            onChanged: (value) {
                              setState(() {
                                _level = value != null
                                    ? LevelHelper.enumValueByDesc(value)
                                    : null;
                              });

                              _filterList();
                            },
                          ),
                          SelectPicker(
                            items: const [
                              'Wybierz...',
                              'Pole Dance',
                              'High Heels',
                              'Fitness',
                              'Stretching'
                            ],
                            selectWidth:
                                MediaQuery.of(context).size.width * 0.42,
                            dropDownWidth: 160,
                            hintText: 'Wybierz zajęcia',
                            onChanged: (value) {
                              setState(() {
                                _className = value;
                              });

                              _filterList();
                            },
                          ),
                          SelectPicker(
                            items: teachers,
                            selectWidth:
                                MediaQuery.of(context).size.width * 0.42,
                            dropDownWidth: 160,
                            hintText: 'Wybierz instruktora',
                            onChanged: (value) {
                              setState(() {
                                _teacher = value;
                              });

                              _filterList();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: Center(
                          child: _date == null
                              ? const Text(
                                  'Wszystkie zajęcia',
                                  style: TextStyle(
                                    color: CustomColors.hintText,
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Wybrana data',
                                      style: TextStyle(
                                        color: CustomColors.hintText,
                                        fontSize: 16,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd.MM.yyyy').format(_date!),
                                      style: const TextStyle(
                                        color: Color(0xFF404040),
                                        fontSize: 16,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (filteredList.isEmpty)
                  const Text('Brak zajęć.')
                else
                  ...filteredList
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: AvailableClassItem(classItem: e),
                          ))
                      .toList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
