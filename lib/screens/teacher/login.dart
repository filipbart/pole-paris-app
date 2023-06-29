import 'package:flutter/material.dart';
import 'package:pole_paris_app/main.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/pages/registration.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/forgot_password.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/validators.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';
import 'package:pole_paris_app/widgets/input.dart';

class LoginTeacherScreen extends StatefulWidget {
  static const id = 'login_teacher';
  const LoginTeacherScreen({super.key});

  @override
  State<LoginTeacherScreen> createState() => _LoginTeacherScreenState();
}

class _LoginTeacherScreenState extends State<LoginTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _submit() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    final validForm = _formKey.currentState!.validate();

    if (validForm == false) {
      return;
    }

    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const LoadingDialog(text: 'Logowanie'))
        .timeout(const Duration(milliseconds: 200), onTimeout: () {
      Navigator.pop(context);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfirmScreen(
            icon: Icons.celebration_rounded,
            title: 'Gratulacje!',
            text: 'Zalogowano pomyślnie :)',
            widgets: [
              ElevatedButton(
                style: CustomButtonStyle.primary,
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const MainPageTeacher())),
                child: const Text('STRONA GŁÓWNA'),
              ),
            ],
          ),
        ),
        ModalRoute.withName('/confirm'),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        'Cześć!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.text,
                        ),
                      ),
                      Text(
                        'Zaloguj się jako instruktor',
                        style: TextStyle(
                          color: CustomColors.text2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Input(
                    controller: _emailController,
                    hint: 'Adres email',
                    inputType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Input(
                    controller: _passwordController,
                    hint: 'Hasło',
                    obscure: true,
                    validator: Validators.validatePassword,
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
                        onPressed: () => Navigator.of(context)
                            .pushNamed(ForgotPasswordScreen.id),
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
                    onPressed: _submit,
                    child: const Text('ZALOGUJ JAKO INSTRUKTOR'),
                  ),
                ),
                ElevatedButton(
                  style: CustomButtonStyle.additional,
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      HomeUnloggedPage.id,
                    );
                  },
                  child: const Text('ZMIEŃ SPOSÓB LOGOWANIA'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Nie masz konta instruktora?',
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
                      foregroundColor: CustomColors.hintText,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(RegistrationPage.id),
                    child: const Text(
                      'Załóż konto tutaj!',
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
