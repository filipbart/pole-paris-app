import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/pages/registration.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/screens/forgot_password.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/validators.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/base/logo.dart';
import 'package:pole_paris_app/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_student';
  final bool teacher;
  const LoginScreen({super.key, this.teacher = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorText;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  _submit() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    final validForm = _formKey.currentState!.validate();

    if (validForm == false) {
      return;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const LoadingDialog(text: 'Logowanie'));

    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then(
      (value) async {
        GetStorage().write('token', value.user!.uid);

        await UserRepository.getMe().then(
          (user) {
            if (user == null) {
              throw Exception();
            }

            if (user.role != Role.teacher && widget.teacher) {
              _onFailure();
              return;
            }

            context.read<UserBloc>().add(GetMe());
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ConfirmScreen(
                  icon: Icons.celebration_rounded,
                  title: widget.teacher ? 'Udało się!' : 'Gratulacje!',
                  text: 'Zalogowano pomyślnie :)',
                  widgets: [
                    ElevatedButton(
                      style: CustomButtonStyle.primary,
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        widget.teacher
                            ? MainPageTeacher.id
                            : MainPageStudent.id,
                      ),
                      child: const Text('STRONA GŁÓWNA'),
                    ),
                  ],
                ),
              ),
            );
          },
        ).onError((error, stackTrace) {
          _passwordController.text = '';
          setState(() {
            _errorText = 'Nie znaleziono użytkownika w bazie';
          });
          Navigator.of(context).pop();
        });
      },
    ).onError(
      (FirebaseAuthException error, stackTrace) {
        if (error.code == 'wrong-password') {
          _passwordController.text = '';
          _formKey.currentState!.validate();
          Navigator.of(context).pop();
          return;
        }

        _onFailure();
      },
    );
  }

  _onFailure() {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FailedScreen(
            button: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: CustomButtonStyle.primary,
              child: const Text('POWRÓT DO LOGOWANIA'),
            ),
            title: 'Logowanie nie powiodło się'),
      ),
    );
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
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                    child: Column(
                      children: [
                        Text(
                          widget.teacher ? 'Cześć!' : 'Witamy ponownie!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.text,
                          ),
                        ),
                        Text(
                          widget.teacher
                              ? 'Zaloguj się jako instruktor'
                              : 'Zaloguj się',
                          style: const TextStyle(
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
                      errorText: _errorText,
                      onChanged: (_) {
                        setState(() {
                          _errorText = null;
                        });
                      },
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
                      child: Text(widget.teacher
                          ? 'ZALOGUJ JAKO INSTRUKTOR'
                          : 'ZALOGUJ'),
                    ),
                  ),
                  ElevatedButton(
                    style: CustomButtonStyle.additional,
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      HomeUnloggedPage.id,
                    ),
                    child: const Text('ZMIEŃ SPOSÓB LOGOWANIA'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      widget.teacher
                          ? 'Nie masz konta instruktora?'
                          : 'Nie posiadasz jeszcze konta?',
                      style: const TextStyle(
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
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegistrationPage(teacher: widget.teacher))),
                      child: Text(
                        widget.teacher
                            ? 'Załóż konto tutaj!'
                            : 'Zarejestruj się za darmo!',
                        style: const TextStyle(
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
      ),
    );
  }
}
