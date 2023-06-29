import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/student/login.dart';
import 'package:pole_paris_app/screens/teacher/login.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';

class HomeUnloggedPage extends StatefulWidget {
  const HomeUnloggedPage({super.key});
  static const id = 'home_unlogged';

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
                    color: CustomColors.line,
                  ),
                ),
                ElevatedButton(
                  style: CustomButtonStyle.primary,
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.id),
                  child: const Text('KURSANT'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: CustomButtonStyle.secondary,
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(LoginTeacherScreen.id),
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
