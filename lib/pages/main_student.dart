import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/student/tab_navigator.dart';

class MainPageStudent extends StatefulWidget {
  static const id = 'main_student';
  const MainPageStudent({super.key});

  @override
  State<MainPageStudent> createState() => _MainPageStudentState();
}

class _MainPageStudentState extends State<MainPageStudent> {
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TabIndexBloc(),
        ),
        BlocProvider(
          create: (context) => ClassesBloc(),
        ),
      ],
      child: BlocBuilder<TabIndexBloc, TabIndexState>(
        builder: (context, state) => Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
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
                  label: 'zapisz się',
                ),
              ],
              currentIndex: state.selectedIndex,
              onTap: (index) {
                if (index == state.selectedIndex) {
                  _navigatorKeys[index]
                      .currentState!
                      .popUntil((route) => route.isFirst);
                } else {
                  context.read<TabIndexBloc>().add(ChangeTab(newIndex: index));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigator(int index) {
    return TabNavigatorStudent(
      navigatorKey: _navigatorKeys[index],
      selectedIndex: index,
    );
  }
}
