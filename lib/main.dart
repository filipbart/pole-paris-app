import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pole_paris_app/screens/student/login.dart';
import 'package:pole_paris_app/screens/teacher/login.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/logo.dart';

void main() {
  runApp(const PoleParisApp());
}

class PoleParisApp extends StatelessWidget {
  const PoleParisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pole Paris App',
        theme: ThemeData(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: const Color(0xFFF2F2F2),
            fontFamily: 'Satoshi',
            useMaterial3: true,
            textTheme: const TextTheme(),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: CustomColors.inputText,
              selectionColor: Color.fromARGB(111, 128, 128, 128),
              selectionHandleColor: CustomColors.inputText,
            )),
        home: const HomeUnloggedPage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute: '/',
        supportedLocales: const [
          Locale('pl', 'PL'),
        ]);
  }
}

class HomeUnloggedPage extends StatefulWidget {
  const HomeUnloggedPage({super.key});

  @override
  State<HomeUnloggedPage> createState() => _HomeUnloggedPageState();
}

class _HomeUnloggedPageState extends State<HomeUnloggedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 45.0,
            right: 45.0,
            bottom: 60.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Logo(
                  width: 270.0,
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  'Zaloguj się jako',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.text2,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.0),
                  child: Divider(
                    thickness: 1.0,
                    color: CustomColors.lines,
                  ),
                ),
                ElevatedButton(
                  style: CustomButtonStyle.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('KURSANT'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: CustomButtonStyle.secondary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginTeacherScreen(),
                      ),
                    );
                  },
                  child: const Text('INSTRUKTOR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
