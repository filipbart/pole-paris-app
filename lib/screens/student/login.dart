import 'package:flutter/material.dart';
import 'package:pole_paris_app/main.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 45.0,
            right: 45.0,
          ),
          child: Center(
            child: Column(
              children: [
                const Logo(
                  width: 150.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
                  child: Column(
                    children: [
                      Text(
                        'Witamy ponownie!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.text,
                        ),
                      ),
                      Text(
                        'Zaloguj się',
                        style: TextStyle(
                          color: CustomColors.text2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Input(
                    /*controller:,*/ hint: 'Adres email',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Input(
                    /*controller:,*/ hint: 'Hasło',
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nie pamiętasz hasła?',
                        style: TextStyle(
                          fontSize: 13,
                          color: CustomColors.hintText,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          )),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Przypomnij hasło.',
                          style: TextStyle(
                            fontSize: 13,
                            color: CustomColors.hintText,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: CustomColors.hintText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                  child: ElevatedButton(
                    style: CustomButtonStyle.primary,
                    onPressed: () {},
                    child: const Text('ZALOGUJ'),
                  ),
                ),
                ElevatedButton(
                  style: CustomButtonStyle.additional,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const HomePage()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text('ZMIEŃ SPOSÓB LOGOWANIA'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Nie posiadasz jeszcze konta?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.hintText,
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Zarejestruj się za darmo!',
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColors.hintText,
                        decoration: TextDecoration.underline,
                        decorationColor: CustomColors.hintText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
