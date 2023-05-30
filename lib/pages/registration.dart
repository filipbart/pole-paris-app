import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _badUserData = false;
  bool _badEmail = false;
  bool _badPhone = false;

  bool _badPassword = false;
  bool _termsAccepted = false;

  final userDataController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final secondPasswordController = TextEditingController();

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    children: [
                      Text(
                        'Dołącz do naszego grona!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Zarejestruj się i korzystaj z usług',
                        style: TextStyle(
                          color: CustomColors.text2,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  runSpacing: 10,
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
                      onChanged: (text) => {},
                    ),
                    Input(
                      controller: emailController,
                      errorText: _badEmail
                          ? 'Błędny adres email. Spróbuj ponownie!'
                          : null,
                      hint: 'Adres email',
                      onChanged: (text) => {},
                    ),
                    Input(
                      controller: phoneController,
                      errorText: _badPhone
                          ? 'Błędny numer telefonu. Spróbuj ponownie!'
                          : null,
                      hint: 'Numer telefonu',
                      onChanged: (text) => {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                  ),
                  child: Wrap(
                    runSpacing: 10,
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
                            _badPassword = text.isEmpty;
                          });
                        },
                        errorText: _badPassword
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
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Transform.scale(
                          scale: 1.7,
                          child: Checkbox(
                            checkColor: Colors.white,
                            hoverColor: CustomColors.inputText,
                            focusColor: CustomColors.inputText,
                            activeColor: CustomColors.inputText,
                            side: const BorderSide(
                              color: CustomColors.inputText,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            value: _termsAccepted,
                            onChanged: (value) {
                              setState(() {
                                _termsAccepted = value ?? false;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          const Text(
                            'Potwierdzam zapoznanie się i akceptuję',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CustomColors.inputText,
                            ),
                          ),
                          SizedBox(
                            height: 22,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: CustomColors.inputText,
                              ),
                              child: const Text(
                                'Regulamin.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.inputText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 50.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
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
                      onPressed: () {},
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
