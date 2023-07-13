import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/services/messaging_service.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/teacher/tab_navigator.dart';

class MainPageTeacher extends StatefulWidget {
  static const id = 'main_teacher';
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

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    context.read<TabIndexBloc>().add(const ChangeTab(newIndex: 1));
  }

  @override
  void initState() {
    super.initState();
    MessagingService.setupToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TabIndexBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ClassesBloc()..add(const GetClasses(forTeacher: true)),
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
                  label: 'dodaj zajęcia',
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
    return TabNavigatorTeacher(
      navigatorKey: _navigatorKeys[index],
      selectedIndex: index,
    );
  }
}
