import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/teacher/add_classes.dart';
import 'package:pole_paris_app/screens/teacher/main_screen.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/teacher/drawer.dart';

class MainPageTeacher extends StatefulWidget {
  const MainPageTeacher({super.key});

  @override
  State<MainPageTeacher> createState() => _MainPageTeacherState();
}

class PageWithAppBar {
  final Widget page;
  final String? title;

  PageWithAppBar({
    required this.page,
    this.title,
  });
}

class _MainPageTeacherState extends State<MainPageTeacher> {
  int _selectedIndex = 0;

  final List<PageWithAppBar> _widgets = [
    PageWithAppBar(page: const MainScreenTeacher()),
    PageWithAppBar(page: Container()),
    PageWithAppBar(page: Container()),
    PageWithAppBar(page: const AddClassesScreen(), title: 'Dodawanie zajęć'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _selectedIndex == 0 ? Colors.white : Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          _widgets.elementAt(_selectedIndex).title ?? '',
          style: const TextStyle(
            color: CustomColors.buttonAdditional,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: _widgets.elementAt(_selectedIndex).title != null
            ? const Border(
                bottom: BorderSide(
                  width: 0.4,
                  color: Color(0xFF838383),
                ),
              )
            : null,
      ),
      drawer: const TeacherDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _widgets.elementAt(_selectedIndex).page,
        ),
      ),
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
