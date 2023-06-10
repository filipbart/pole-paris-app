import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/teacher/add_class.dart';
import 'package:pole_paris_app/screens/teacher/main_screen.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.selectedIndex,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final int selectedIndex;

  static final List<Widget> pages = [
    const MainScreenTeacher(),
    Container(),
    Container(),
    const AddClassScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) => MaterialPageRoute(
        builder: (context) => pages[selectedIndex],
        settings: routeSettings,
      ),
    );
  }
}
