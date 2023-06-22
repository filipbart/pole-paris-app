import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/profile.dart';
import 'package:pole_paris_app/screens/teacher/add_class.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';

import 'package:pole_paris_app/widgets/input.dart';

import 'package:pole_paris_app/widgets/teacher/add_picture_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

TextStyle labelStyle = const TextStyle(
  color: CustomColors.inputText,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _noImage = false;
  bool _badUserData = false;
  bool _badEmail = false;
  bool _badPhone = false;

  bool _badPassword = false;
  bool _badSecondPassword = false;

  final ImagePicker _picker = ImagePicker();

  final userDataController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
  final secondPasswordController = TextEditingController();
  final PhoneInputFormatter _formatter = PhoneInputFormatter();
  XFile? _image;
  dynamic _pickImageError;

  Future<void> _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _image = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

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

      _badPassword = password.isEmpty;
      _badSecondPassword = secondPassword.isEmpty || password != secondPassword;
    });

    // if (_badUserData ||
    //     _badEmail ||
    //     _badPhone ||
    //     _badPassword ||
    //     _badSecondPassword) {
    //   return;
    // }

    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const LoadingDialog(text: 'Zapisywanie zmian'))
        .timeout(const Duration(milliseconds: 200), onTimeout: () {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfirmScreen(
            icon: Icons.auto_awesome_outlined,
            title: 'Udało się!',
            text: 'Zmiany zostały zapisane',
            widgets: [
              ElevatedButton(
                style: CustomButtonStyle.primary,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));
                },
                child: const Text('POWRÓT DO PROFILU'),
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
    userDataController.text = 'Aleksandra jakaśtam';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Edytuj profil', appBar: AppBar()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Edytuj zdjęcie',
                    style: labelStyle,
                  ),
                ),
                Wrap(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _image == null
                        ? [
                            AddPictureButton(
                              circle: true,
                              onPressed: () async {
                                await _onImageButtonPressed(ImageSource.gallery,
                                    context: context);
                                setState(() {
                                  _noImage = _image == null;
                                });
                              },
                              icon: Icons.add_photo_alternate_outlined,
                              label: 'Wybierz z biblioteki',
                            ),
                            AddPictureButton(
                              circle: true,
                              onPressed: () async {
                                await _onImageButtonPressed(ImageSource.camera,
                                    context: context);
                                setState(() {
                                  _noImage = _image == null;
                                });
                              },
                              icon: Icons.add_a_photo_outlined,
                              label: 'Zrób zdjęcie',
                            ),
                          ]
                        : [
                            _pickImageError != null
                                ? Center(
                                    child: Text(
                                        'Błąd wyboru obrazka: $_pickImageError'))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(File(_image!.path),
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Center(
                                                child: Text(
                                                    'Nieprawidłowe zdjęcie'))),
                                  ),
                            SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                style: changePictureStyle,
                                child: const Text('ZMIEŃ'),
                              ),
                            )
                          ],
                  ),
                  if (_noImage)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          'Brak wybranego zdjęcia. Wybierz zdjecie.',
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColors.error,
                            fontWeight: FontWeight.w700,
                            height: 0.9,
                          ),
                        ),
                      ),
                    ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Edytuj dane personalne',
                    style: labelStyle,
                  ),
                ),
                const Divider(
                  color: Color(0xFFBDBDBD),
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      Input(
                        controller: userDataController,
                        errorText: _badUserData
                            ? 'Błędne imie i nazwisko. Spróbuj ponownie!'
                            : null,
                        hint: 'Imię i nazwisko',
                        labelText: 'Imię i nazwisko',
                        onChanged: (text) {
                          setState(() {
                            _badUserData = text.isEmpty;
                          });
                        },
                        withBorder: false,
                        suffixIcon: const Icon(
                          Icons.edit_outlined,
                          color: CustomColors.hintText,
                          size: 25,
                        ),
                      ),
                      Input(
                        controller: emailController,
                        hint: 'Adres e-mail',
                        labelText: 'Adres e-mail',
                        errorText: _badEmail
                            ? 'Błędny adres email. Spróbuj ponownie!'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            _badEmail = text.isEmpty;
                          });
                        },
                        withBorder: false,
                        inputType: TextInputType.emailAddress,
                        suffixIcon: const Icon(
                          Icons.edit_outlined,
                          color: CustomColors.hintText,
                          size: 25,
                        ),
                      ),
                      Input(
                        controller: phoneController,
                        hint: 'Numer telefonu',
                        labelText: 'Numer telefonu',
                        errorText: _badPhone
                            ? 'Błędny numer telefonu. Spróbuj ponownie!'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            _badPhone = text.isEmpty;
                          });
                        },
                        withBorder: false,
                        inputType: TextInputType.number,
                        formatter: _formatter,
                        suffixIcon: const Icon(
                          Icons.edit_outlined,
                          color: CustomColors.hintText,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Zmień hasło',
                    style: labelStyle,
                  ),
                ),
                const Divider(
                  color: Color(0xFFBDBDBD),
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      Input(
                        controller: passwordController,
                        hint: 'Hasło',
                        labelText: 'Wprowadź hasło',
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
                        labelText: 'Powtórz hasło',
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
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 15),
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: CustomButtonStyle.primary,
                    child: const Text('ZAPISZ ZMIANY'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: CustomButtonStyle.secondaryTransparent,
                  child: const Text('ANULUJ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
