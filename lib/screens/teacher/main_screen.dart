import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/drawer.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/class_item.dart';

class MainScreenTeacher extends StatefulWidget {
  const MainScreenTeacher({super.key});

  @override
  State<MainScreenTeacher> createState() => _MainScreenTeacherState();
}

class _MainScreenTeacherState extends State<MainScreenTeacher> {
  late Map<String, List<Class>>? mappedClasses;
  static List<Class> classes = [];

  late List<DrawerListTileItem> drawerItems = [
    DrawerListTileItem('Dodaj zajęcia', () {
      Navigator.pop(context);
      context.read<TabIndexBloc>().add(const ChangeTab(newIndex: 3));
    }),
    DrawerListTileItem('Twoje zajęcia', () {}),
    DrawerListTileItem('Profil instruktora', () {
      Navigator.pop(context);
      context.read<TabIndexBloc>().add(const ChangeTab(newIndex: 2));
    }),
    DrawerListTileItem('Ustawienia', () {}),
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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          drawer: BaseDrawer(
            teacher: true,
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
                  child: BlocBuilder<ClassesBloc, ClassesState>(
                    builder: (context, state) {
                      final classes = state.classes;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Logo(
                            width: 180,
                          ),
                          Text(
                            'Cześć\n${user?.getFirstName ?? ''}!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                                context
                                    .read<TabIndexBloc>()
                                    .add(const ChangeTab(newIndex: 3));
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
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Wrap(
                                runSpacing: 10,
                                children: [
                                  if (classes.isNotEmpty) ...[
                                    ..._upcomingClasses(classes)
                                  ] else
                                    const Center(
                                      child: Text(
                                        'Nie masz żadnych zajęć',
                                        style: TextStyle(
                                          color: CustomColors.hintText,
                                          fontSize: 16,
                                          fontFamily: 'Satoshi',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
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
                                                  const ClassesListScreen(),
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
                              firstDay: DateTime.now(),
                              classDays: classes.map((e) => e.date).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                GetStorage().remove('token');
                                Navigator.pushReplacementNamed(
                                    context, HomeUnloggedPage.id);
                              },
                              style: CustomButtonStyle.secondary,
                              child: const Text('WYLOGUJ'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _upcomingClasses(List<Class> classes) {
    DateTime? previousDate;
    List<Widget> result = [];

    classes.take(2).forEach((e) {
      if (previousDate != null && previousDate!.isSameDate(e.date) ||
          previousDate == null) {
        result.add(
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              DateFormat('dd.MM.yyyy').format(e.date),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }
      result.add(
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE1E1E1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClassItem(classItem: classes.first),
        ),
      );

      previousDate = e.date;
    });

    return result;
  }
}
