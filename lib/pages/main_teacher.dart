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

class _MainPageTeacherState extends State<MainPageTeacher> {
  int _selectedIndex = 0;

  final List<Widget> _widgets = [
    const MainScreenTeacher(),
    Container(),
    Container(),
    const AddClassesScreen(),
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
      ),
      drawer: const TeacherDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _widgets.elementAt(_selectedIndex),
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
            fontSize: 11,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.w500,
          ),
          selectedItemColor: CustomColors.text,
          selectedLabelStyle: const TextStyle(
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.bold,
            fontSize: 13,
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
