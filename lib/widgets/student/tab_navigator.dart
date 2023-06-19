import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/student/main_screen.dart';

class TabNavigatorStudent extends StatelessWidget {
  const TabNavigatorStudent({
    super.key,
    required this.navigatorKey,
    required this.selectedIndex,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final int selectedIndex;

  static final List<Widget> pages = [
    const MainScreenStudent(),
    Container(),
    Container(),
    Container(),
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
