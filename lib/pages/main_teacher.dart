import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/tab_navigator.dart';
import 'package:pole_paris_app/widgets/teacher/drawer.dart';

class MainPageTeacher extends StatefulWidget {
  const MainPageTeacher({super.key});

  @override
  State<MainPageTeacher> createState() => _MainPageTeacherState();
}

class _MainPageTeacherState extends State<MainPageTeacher> {
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
            )
          : null,
      drawer: const TeacherDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildNavigator(0),
          _buildNavigator(1),
          _buildNavigator(2),
          _buildNavigator(3),
        ],
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

  Widget _buildNavigator(int index) {
    return TabNavigator(
      navigatorKey: _navigatorKeys[index],
      selectedIndex: index,
    );
  }
}
