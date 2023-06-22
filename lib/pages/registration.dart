import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:pole_paris_app/main.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/input.dart';

import '../widgets/loader.dart';

class RegistrationPage extends StatefulWidget {
  final bool teacher;
  const RegistrationPage({super.key, this.teacher = false});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _badUserData = false;
  bool _badEmail = false;
  bool _badPhone = false;

  bool _badPassword = false;
  bool _badSecondPassword = false;
  bool _termsAccepted = false;
  bool _errorTerms = false;

  final userDataController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final secondPasswordController = TextEditingController();
  final PhoneInputFormatter _formatter = PhoneInputFormatter();

  _submit() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    final userData = userDataController.value.text;
    final bool userDataValid =
        RegExp(r"^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$").hasMatch(userData);

    final email = emailController.value.text;
    final bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email);

    final phone = phoneController.value.text.trim();
    final bool phoneValid = RegExp(
            r"\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$")
        .hasMatch(phone);

    final password = passwordController.value.text;
    final secondPassword = secondPasswordController.value.text;

    setState(() {
      _badUserData = userDataValid || userData.isEmpty;
      _badEmail = emailValid || email.isEmpty;
      _badPhone = phoneValid || phone.isEmpty;

      _errorTerms = !_termsAccepted;

      _badPassword = password.isEmpty;
      _badSecondPassword = secondPassword.isEmpty || password != secondPassword;
    });

    if (_badUserData ||
        _badEmail ||
        _badPhone ||
        _errorTerms ||
        _badPassword ||
        _badSecondPassword) {
      return;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => LoadingDialog(
            text: widget.teacher
                ? 'Wysyłanie prośby o\u{00A0}rejestracje jako instruktor'
                : 'Tworzenie konta')).timeout(const Duration(milliseconds: 200),
        onTimeout: () {
      Navigator.pop(context);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfirmScreen(
            icon: widget.teacher
                ? Icons.celebration_rounded
                : Icons.person_2_outlined,
            title: widget.teacher ? 'Udało się!' : 'Gratulacje!',
            text: widget.teacher
                ? '''Twoja prośba o rejestracje jako instruktor zostałą przekazana do Pole Paris Studio.\n\nPo weryfikacji dostaniesz od nas wiadomość na adres e-mail'''
                : 'Zarejestrowano pomyślnie.',
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
                child: Text(
                  widget.teacher ? 'POWRÓT DO STRONY STARTOWEJ' : 'ZALOGUJ SIĘ',
                  style: widget.teacher ? const TextStyle(fontSize: 15) : null,
                ),
              ),
            ],
          ),
        ),
        ModalRoute.withName('/confirm'),
      );
    });
  }

  @override
  void initState() {
    PhoneInputFormatter.replacePhoneMask(
        countryCode: 'PL', newMask: '+00 000 000 000');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 45.0,
              right: 45.0,
              bottom: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Column(
                      children: [
                        Text(
                          widget.teacher
                              ? 'Cześć!'
                              : 'Dołącz do naszego grona!',
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.teacher
                              ? 'Dołącz do grona instruktorów'
                              : 'Zarejestruj się i korzystaj z usług',
                          style: const TextStyle(
                            color: CustomColors.text2,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Wrap(
                  runSpacing: 8,
                  children: [
                    const Text(
                      'Wprowadź dane',
                      style: TextStyle(
                        color: CustomColors.inputText,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Input(
                      controller: userDataController,
                      errorText: _badUserData
                          ? 'Błędne imie i nazwisko. Spróbuj ponownie!'
                          : null,
                      hint: 'Imię i nazwisko',
                      onChanged: (text) {
                        setState(() {
                          _badUserData = text.isEmpty;
                        });
                      },
                    ),
                    Input(
                      controller: emailController,
                      errorText: _badEmail
                          ? 'Błędny adres email. Spróbuj ponownie!'
                          : null,
                      hint: 'Adres email',
                      onChanged: (text) {
                        setState(() {
                          _badEmail = text.isEmpty;
                        });
                      },
                      inputType: TextInputType.emailAddress,
                    ),
                    Input(
                      controller: phoneController,
                      errorText: _badPhone
                          ? 'Błędny numer telefonu. Spróbuj ponownie!'
                          : null,
                      hint: 'Numer telefonu',
                      onChanged: (text) {
                        setState(() {
                          _badPhone = text.isEmpty;
                        });
                      },
                      inputType: TextInputType.number,
                      formatter: _formatter,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                  ),
                  child: Wrap(
                    runSpacing: 8,
                    children: [
                      const Text(
                        'Ustal hasło',
                        style: TextStyle(
                          color: CustomColors.inputText,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Input(
                        controller: passwordController,
                        hint: 'Hasło',
                        obscure: true,
                        onChanged: (text) {
                          setState(() {
                            _badPassword = text.isEmpty;
                          });
                        },
                        errorText: _badPassword
                            ? 'Błędne hasło. Spróbuj ponownie.'
                            : null,
                      ),
                      Input(
                        controller: secondPasswordController,
                        hint: 'Powtórz hasło',
                        obscure: true,
                        onChanged: (text) {
                          setState(() {
                            _badSecondPassword = text.isEmpty;
                          });
                        },
                        errorText: _badSecondPassword
                            ? 'Hasła nie pasują. Spróbuj ponownie.'
                            : null,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Transform.scale(
                        scale: 1.7,
                        child: Checkbox(
                          checkColor: Colors.white,
                          hoverColor: CustomColors.inputText,
                          focusColor: CustomColors.inputText,
                          activeColor: CustomColors.inputText,
                          side: BorderSide(
                            color: _errorTerms
                                ? CustomColors.error
                                : CustomColors.inputText,
                            width: 1,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _errorTerms = false;
                              _termsAccepted = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 2,
                      text: TextSpan(
                        text: 'Potwierdzam zapoznanie się\ni akceptuję ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _errorTerms
                              ? CustomColors.error
                              : CustomColors.inputText,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'Regulamin.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              color: _errorTerms
                                  ? CustomColors.error
                                  : CustomColors.inputText,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 30.0,
                  ),
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: CustomButtonStyle.primary,
                    child: const Text('ZAPISZ SIĘ'),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 25,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: CustomColors.inputText,
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeUnloggedPage(),
                          )),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.buttonAdditional,
                            decoration: TextDecoration.underline,
                          ),
                          children: [
                            TextSpan(text: 'Masz już konto? '),
                            TextSpan(
                              text: 'Zaloguj się.',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
