import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:pole_paris_app/repositories/user_repository.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/models/user.dart';
import 'package:pole_paris_app/pages/home_unlogged.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/validators.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/input.dart';

class RegistrationPage extends StatefulWidget {
  final bool teacher;
  const RegistrationPage({super.key, this.teacher = false});

  static const id = 'registration';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  bool _errorTerms = false;

  final _userDataController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secondPasswordController = TextEditingController();
  final PhoneInputFormatter _formatter = PhoneInputFormatter();

  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;

  String? _validateSecondPassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'Hasła nie pasują. Spróbuj ponownie.';
    }

    final password = _passwordController.value.text;
    if (password != text) {
      return 'Hasła nie pasują. Spróbuj ponownie!';
    }

    return null;
  }

  _submit() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    final validForm = _formKey.currentState!.validate();

    setState(() {
      _errorTerms = !_termsAccepted;
    });

    if (_errorTerms || validForm == false) {
      return;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => LoadingDialog(
            text: widget.teacher
                ? 'Wysyłanie prośby o\u{00A0}rejestracje jako instruktor'
                : 'Tworzenie konta'));

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) async {
      final userId = value.user!.uid;

      final newUser = User(
        fullName: _userDataController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        role: Role.student,
        id: userId,
        dateCreatedUtc: DateTime.now().toUtc(),
      );

      await UserRepository.create(newUser).then((value) {
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
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    HomeUnloggedPage.id,
                  ),
                  child: Text(
                    widget.teacher
                        ? 'POWRÓT DO STRONY STARTOWEJ'
                        : 'ZALOGUJ SIĘ',
                    style:
                        widget.teacher ? const TextStyle(fontSize: 15) : null,
                  ),
                ),
              ],
            ),
          ),
          ModalRoute.withName('/confirm'),
        );
      }).onError((FirebaseAuth.FirebaseAuthException error, stackTrace) {
        print(error.code);
      });
    }).onError((error, stackTrace) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FailedScreen(
              button: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(RegistrationPage.id),
                style: CustomButtonStyle.primary,
                child: const Text('POWRÓT'),
              ),
              title: 'Coś poszło nie tak...'),
        ),
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
  void dispose() {
    _userDataController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _secondPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                        controller: _userDataController,
                        hint: 'Imię i nazwisko',
                        validator: Validators.validateUserData,
                      ),
                      Input(
                        controller: _emailController,
                        hint: 'Adres email',
                        validator: Validators.validateEmail,
                        inputType: TextInputType.emailAddress,
                      ),
                      Input(
                        controller: _phoneController,
                        hint: 'Numer telefonu',
                        validator: Validators.validatePhoneNumber,
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
                          controller: _passwordController,
                          hint: 'Hasło',
                          obscure: true,
                          validator: Validators.validatePassword,
                        ),
                        Input(
                          controller: _secondPasswordController,
                          hint: 'Powtórz hasło',
                          obscure: true,
                          validator: _validateSecondPassword,
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
                        onPressed: () => Navigator.pushReplacementNamed(
                          context,
                          HomeUnloggedPage.id,
                        ),
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
      ),
    );
  }
}
