import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/models/user.dart' as UserModel;
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/screens/teacher/add_class.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/validators.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/input.dart';
import 'package:pole_paris_app/widgets/large_input.dart';
import 'package:pole_paris_app/widgets/teacher/add_picture_button.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel.User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

TextStyle labelStyle = const TextStyle(
  color: CustomColors.inputText,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserModel.User _user;
  final _formKey = GlobalKey<FormState>();
  bool _noImage = false;

  final ImagePicker _picker = ImagePicker();

  final _userDataController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secondPasswordController = TextEditingController();
  final _descriptionController = TextEditingController();
  final PhoneInputFormatter _formatter = PhoneInputFormatter();
  final _auth = FirebaseAuth.instance;
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

  String? _validateSecondPassword(String? text) {
    final password = _passwordController.value.text;
    if (password.isNotEmpty && password != text) {
      return 'Hasła nie pasują. Spróbuj ponownie!';
    }

    return null;
  }

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
            const LoadingDialog(text: 'Zapisywanie zmian'));

    String? url;
    if (_image != null) {
      final userId = GetStorage().read('token');
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user-images/$userId/picture.jpg');
      final image = File(_image!.path);
      await storageRef.putFile(image).then((p0) async {
        await FirebaseStorage.instance
            .ref()
            .child('user-images/${GetStorage().read('token')}/picture.jpg')
            .getDownloadURL()
            .then((value) {
          url = value;
        }, onError: (e) {
          url = null;
        });
      }).onError((error, stackTrace) {
        _onFailure();
        return;
      });
    }

    ;

    if (_emailController.text != _auth.currentUser!.email) {
      await _auth.currentUser!
          .updateEmail(_emailController.text)
          .onError((error, stackTrace) {
        _onFailure();
        return;
      });
    }

    if (_passwordController.text.isNotEmpty) {
      await _auth.currentUser!
          .updatePassword(_passwordController.text)
          .onError((error, stackTrace) async {
        if (_emailController.text != _auth.currentUser!.email) {
          await _auth.currentUser!
              .updateEmail(_user.email)
              .onError((error, stackTrace) {
            _onFailure();
            return;
          });
        }
        _onFailure();
        return;
      });
    }

    if (!mounted) return;
    context.read<UserBloc>().add(UpdateUser(_userDataController.text,
        _emailController.text, _phoneController.text, url));

    _onSucces();
  }

  _onSucces() {
    final rootContext = context;
    final role = rootContext.read<UserBloc>().state.user!.role;

    Navigator.of(rootContext, rootNavigator: true).pop();
    Navigator.of(rootContext, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ConfirmScreen(
          icon: Icons.auto_awesome_outlined,
          title: 'Udało się!',
          text: 'Zmiany zostały zapisane',
          widgets: [
            ElevatedButton(
              style: CustomButtonStyle.primary,
              onPressed: () {
                context.read<UserBloc>().add(GetMe());
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                    role == Role.teacher
                        ? MainPageTeacher.id
                        : MainPageStudent.id);
              },
              child: const Text('POWRÓT DO PROFILU'),
            ),
          ],
        ),
      ),
      ModalRoute.withName(
          role == Role.teacher ? MainPageTeacher.id : MainPageStudent.id),
    );
  }

  _onFailure() {
    final rootContext = context;
    Navigator.of(rootContext, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => FailedScreen(
            button: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: CustomButtonStyle.primary,
              child: const Text('POWRÓT DO EDYCJI'),
            ),
            title: 'Coś poszło nie tak...'),
      ),
    );
  }

  @override
  void initState() {
    _user = widget.user;
    PhoneInputFormatter.replacePhoneMask(
        countryCode: 'PL', newMask: '+00 000 000 000');
    _userDataController.text = _user.fullName;
    _emailController.text = _user.email;
    _phoneController.text = _user.phoneNumber;
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
      appBar: BaseAppBar(title: 'Edytuj profil', appBar: AppBar()),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40),
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
                                  await _onImageButtonPressed(
                                      ImageSource.gallery,
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
                                  await _onImageButtonPressed(
                                      ImageSource.camera,
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
                          controller: _userDataController,
                          hint: 'Imię i nazwisko',
                          labelText: 'Imię i nazwisko',
                          validator: Validators.validateUserData,
                          withBorder: false,
                          suffixIcon: const Icon(
                            Icons.edit_outlined,
                            color: CustomColors.hintText,
                            size: 25,
                          ),
                        ),
                        Input(
                          controller: _emailController,
                          hint: 'Adres e-mail',
                          labelText: 'Adres e-mail',
                          validator: Validators.validateEmail,
                          withBorder: false,
                          inputType: TextInputType.emailAddress,
                          suffixIcon: const Icon(
                            Icons.edit_outlined,
                            color: CustomColors.hintText,
                            size: 25,
                          ),
                        ),
                        Input(
                          controller: _phoneController,
                          hint: 'Numer telefonu',
                          labelText: 'Numer telefonu',
                          validator: Validators.validatePhoneNumber,
                          withBorder: false,
                          inputType: TextInputType.number,
                          formatter: _formatter,
                          suffixIcon: const Icon(
                            Icons.edit_outlined,
                            color: CustomColors.hintText,
                            size: 25,
                          ),
                        ),
                        if (_user.role == Role.teacher)
                          LargeInput(
                            controller: _descriptionController,
                            hint: 'Opis',
                            labelText: 'Opis',
                          )
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
                          controller: _passwordController,
                          hint: 'Hasło',
                          labelText: 'Wprowadź hasło',
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null;
                            }
                            return Validators.validatePassword(value);
                          },
                        ),
                        Input(
                          controller: _secondPasswordController,
                          hint: 'Powtórz hasło',
                          labelText: 'Powtórz hasło',
                          obscure: true,
                          validator: _validateSecondPassword,
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
      ),
    );
  }
}
