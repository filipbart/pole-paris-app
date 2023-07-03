import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/pages/registration.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/validators.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool teacher;
  static const id = 'forgot_password';
  const ForgotPasswordScreen({super.key, this.teacher = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? _errorText;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  _submit() async {
    final validForm = _formKey.currentState!.validate();

    if (validForm == false) {
      return;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const LoadingDialog(text: 'Wysyłanie maila'));

    await _auth
        .sendPasswordResetEmail(email: _emailController.text.trim())
        .then((value) {
      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfirmScreen(
            icon: Icons.email_outlined,
            title: 'Sprawdź skrzynkę!',
            text: 'Wysłaliśmy do Ciebie wiadomość na wskazany adres e-mail',
            widgets: [
              ElevatedButton(
                style: CustomButtonStyle.primary,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    HomeUnloggedPage.id,
                  );
                },
                child: const Text('POWRÓT DO LOGOWANIA'),
              ),
              ElevatedButton(
                style: CustomButtonStyle.secondary,
                onPressed: () => Navigator.pop(context),
                child: const Text('SPRÓBUJ PONOWNIE'),
              ),
            ],
          ),
        ),
      );
    }).onError((FirebaseAuthException error, stackTrace) {
      print(error.code);
      if (error.code == 'user-not-found') {
        _emailController.text = '';
        setState(() {
          _errorText = 'Brak wybranego adresu e-mail w naszej bazie.';
        });
        Navigator.of(context).pop();
        return;
      }

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FailedScreen(
              button: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(ForgotPasswordScreen.id),
                style: CustomButtonStyle.primary,
                child: const Text('POWRÓT'),
              ),
              title: 'Coś poszło nie tak...'),
        ),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 45.0,
              right: 45.0,
              bottom: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Column(
                            children: [
                              Text(
                                'Nie pamiętasz hasła?',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Podaj swój adres email',
                                style: TextStyle(
                                  color: CustomColors.text2,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 10.0),
                      child: Input(
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                        errorText: _errorText,
                        hint: 'Adres email',
                        validator: Validators.validateEmail,
                        onChanged: (_) {
                          setState(() {
                            _errorText = null;
                          });
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return CustomColors.text2;
                                }
                                return CustomColors.buttonAdditional;
                              },
                            ),
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(58.0),
                              ),
                            ),
                            textStyle:
                                const MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                          ),
                          child: const Text('ANULUJ'),
                        ),
                        ElevatedButton(
                          style: CustomButtonStyle.primaryWithoutSize,
                          onPressed: _submit,
                          child: const Text('WYŚLIJ'),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: SizedBox(
                    height: 25,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: CustomColors.hintText,
                        ),
                        onPressed: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistrationPage(teacher: widget.teacher))),
                        child: const Text(
                          'Zarejestruj się za darmo!',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.hintText),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
