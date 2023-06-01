import 'package:flutter/material.dart';
import 'package:pole_paris_app/main.dart';
import 'package:pole_paris_app/pages/registration.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/loader.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool _badEmail = false;
  String _errorText = 'Błędny adres email. Spróbuj ponownie!';

  _submit() {
    final email = emailController.value.text;
    final bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email);

    setState(() {
      _badEmail = emailValid || email.isEmpty;
      _errorText = 'Błędny adres email. Spróbuj ponownie!';
    });

    if (_badEmail) {
      return;
    }

    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const LoadingDialog(text: 'Wysyłanie maila'))
        .timeout(const Duration(seconds: 2), onTimeout: () {
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HomeUnloggedPage()));
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      hint: 'Adres email',
                      errorText: _badEmail ? _errorText : null,
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
                          textStyle: const MaterialStatePropertyAll<TextStyle>(
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
                      onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RegistrationPage()),
                          ),
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
    );
  }
}
