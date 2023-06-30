import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/screens/student/about.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/screens/student/contact.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/drawer.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';
import 'package:pole_paris_app/widgets/student/carnet.dart';
import 'package:pole_paris_app/widgets/teacher/calendar.dart';
import 'package:pole_paris_app/widgets/teacher/class_item.dart';

class MainScreenStudent extends StatefulWidget {
  const MainScreenStudent({super.key});

  @override
  State<MainScreenStudent> createState() => _MainScreenStudentState();
}

class _MainScreenStudentState extends State<MainScreenStudent> {
  late Map<String, List<Class>>? mappedClasses;
  static List<Class> classes = [
    // Class(
    //   name: 'Test',
    //   date: DateTime.now(),
    //   hourSince: '09:30',
    //   hourTo: '10:30',
    //   level: Level.base,
    //   places: 5,
    //   description: 'Test',
    //   picture: '',
    //   teacher: User(
    //     classes: [],
    //     dateCreatedUtc: DateTime.now(),
    //     email: 'email@email.com',
    //     fullName: 'Magdalena Jakaś',
    //     id: 1,
    //     memberships: [],
    //     phoneNumber: '+48111222333',
    //     role: Role.instructor,
    //   ),
    //   memberships: [
    //     Membership(
    //       id: 1,
    //       type: MembershipType.base,
    //       expirationDate: DateTime.now(),
    //       classes: [],
    //       dateCreatedUtc: DateTime.now(),
    //     ),
    //   ],
    //   id: 1,
    //   dateCreatedUtc: DateTime.now(),
    // ),
  ];

  late List<DrawerListTileItem> drawerItems = [
    DrawerListTileItem('Zapisz się na zajęcia', () {
      Navigator.pop(context);
      context.read<TabIndexBloc>().add(const ChangeTab(newIndex: 3));
    }),
    DrawerListTileItem('Wykup karnet', () {}),
    DrawerListTileItem('Twoje zajęcia', () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ClassesListScreen(forStudent: true)));
    }),
    DrawerListTileItem('Profil', () {
      Navigator.pop(context);
      context.read<TabIndexBloc>().add(const ChangeTab(newIndex: 2));
    }),
    DrawerListTileItem(
      'O nas',
      () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()));
      },
    ),
    DrawerListTileItem(
        'Kontakt',
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ContactScreen()))),
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
    context.read<MembershipsBloc>().add(GetAllMemberships());
    classes.sortBy((element) => element.date);
    mappedClasses =
        groupBy(classes, (p0) => DateFormat('dd.MM.yyyy').format(p0.date));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/img/logo.png'), context);
    return BlocProvider(
      create: (context) => UserBloc()..add(GetMeTask()),
      child: Scaffold(
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
                      width: 220,
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return Text(
                          'Witaj ponownie\n${state.user?.getFirstName}!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            color: CustomColors.text,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
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
                            if (mappedClasses != null &&
                                mappedClasses!.isNotEmpty) ...[
                              ..._upcomingClasses(
                                  mappedClasses!.entries.first.key,
                                  mappedClasses!.entries.first.value),
                              if (mappedClasses!.entries.first.value.length ==
                                  1)
                                ..._upcomingClasses(
                                    mappedClasses!.entries.last.key,
                                    mappedClasses!.entries.last.value),
                            ] else
                              const Center(
                                  child: Text(
                                'Brak zajęć',
                                style: TextStyle(
                                  color: CustomColors.hintText,
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
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
                                            const ClassesListScreen(
                                                forStudent: true),
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
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: BlocBuilder<MembershipsBloc, MembershipsState>(
                          builder: (context, state) {
                            return Wrap(
                              runSpacing: 15,
                              children: [
                                //TODO obsługa kiedy brak; do buildera
                                if (state.userMemberships.isEmpty) ...[
                                  const Center(
                                      child: Text(
                                    'Brak zakupionych karnetów',
                                    style: TextStyle(
                                      color: CustomColors.hintText,
                                      fontSize: 16,
                                      fontFamily: 'Satoshi',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                ] else ...[
                                  ...state.userMemberships
                                      .map((e) => _buildMembership(e))
                                ],

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                      right: 15,
                                      left: 15,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ClassesListScreen(
                                                    forStudent: true),
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
                            );
                          },
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
                        onPressed: () {
                          GetStorage().remove('token');
                          Navigator.of(context).pop();
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed(HomeUnloggedPage.id);
                        },
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

  Widget _buildMembership(Membership membership) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.line),
        borderRadius: BorderRadius.circular(20),
      ),
      child: UserCarnet(
        membership: membership,
      ),
    );
  }
}
