import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/repositories/class_repository.dart';
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
  final Future<List<Class>> _getAvailableClasses =
      ClassRepository.getAvailableClasses();

  bool _isLoading = false;
  List<Class>? _filteredList;
  List<Class> _classes = [];
  List<String> _teachers = [];

  _filterList() {
    var tempFilteredList = _classes;

    if (_date != null) {
      tempFilteredList = tempFilteredList
          .where((element) => element.date.isSameDate(_date!))
          .toList();
    }

    if (_level != null && _level! != Level.all) {
      tempFilteredList =
          tempFilteredList.where((element) => element.level == _level).toList();
    }

    if (_teacher != null) {
      tempFilteredList = tempFilteredList
          .where((element) => element.teacher.fullName == _teacher)
          .toList();
    }

    if (_className != null) {
      tempFilteredList = tempFilteredList
          .where((element) =>
              element.name.toLowerCase() == _className!.toLowerCase())
          .toList();
    }

    setState(() {
      _filteredList = tempFilteredList;
    });
  }

  late List<String> levels;

  DateTime? _date;
  Level? _level;
  String? _teacher;
  String? _className;

  @override
  void initState() {
    super.initState();
    var tempLevels = Level.values.map((e) => e.description).toList();
    tempLevels.insert(0, 'Wybierz...');
    levels = tempLevels;
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    final classes = await ClassRepository.getAvailableClasses();

    setState(() {
      _classes = classes;
      _filteredList = _classes;
    });
    var tempTeachers = groupBy(_classes, (p0) => p0.teacher.fullName)
        .entries
        .map((e) => e.key)
        .toList();
    tempTeachers.insert(0, 'Wybierz...');
    setState(() {
      _teachers = tempTeachers;
      _isLoading = false;
    });
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
        child: FutureBuilder(
            future: _getAvailableClasses,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _classes = snapshot.data!;

                var tempTeachers =
                    groupBy(_classes, (p0) => p0.teacher.fullName)
                        .entries
                        .map((e) => e.key)
                        .toList();
                tempTeachers.insert(0, 'Wybierz...');
                _teachers = tempTeachers;

                return RefreshIndicator(
                  color: CustomColors.text,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                                          MediaQuery.of(context).size.width *
                                              0.42,
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
                                          MediaQuery.of(context).size.width *
                                              0.42,
                                      dropDownWidth: 160,
                                      hintText: 'Wybierz poziom',
                                      onChanged: (value) {
                                        setState(() {
                                          _level = value != null
                                              ? LevelHelper.enumValueByDesc(
                                                  value)
                                              : null;
                                        });

                                        _filterList();
                                      },
                                    ),
                                    SelectPicker(
                                      items: const [
                                        'Wybierz...',
                                        'Pole Dance',
                                        'Tabata',
                                        'Zdrowy kręgosłup',
                                        'Rollowanie',
                                        'Stretching'
                                      ],
                                      selectWidth:
                                          MediaQuery.of(context).size.width *
                                              0.42,
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
                                      items: _teachers,
                                      selectWidth:
                                          MediaQuery.of(context).size.width *
                                              0.42,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                DateFormat('dd.MM.yyyy')
                                                    .format(_date!),
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
                          if (_isLoading == false) ...[
                            if (_classes.isEmpty)
                              const Text('Brak zajęć.')
                            else
                              ...(_filteredList ?? _classes)
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: AvailableClassItem(classItem: e),
                                      ))
                                  .toList(),
                          ] else
                            const Center(
                              child: CircularProgressIndicator(
                                color: CustomColors.text,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Błąd przy pobieraniu listy zajęć'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.text,
                  ),
                );
              }
            }),
      ),
    );
  }
}
