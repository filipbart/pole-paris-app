import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/bloc/bloc_exports.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/models/roles.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/pages/main_teacher.dart';
import 'package:pole_paris_app/repositories/class_repository.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/failed.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/app_bar.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';
import 'package:pole_paris_app/widgets/teacher/class_field_label.dart';

class AddClassSummary extends StatefulWidget {
  final Class newClass;
  const AddClassSummary({super.key, required this.newClass});

  @override
  State<AddClassSummary> createState() => _AddClassSummaryState();
}

class _AddClassSummaryState extends State<AddClassSummary> {
  _submit() async {
    bool showFailure = false;
    final newClass = widget.newClass;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const LoadingDialog(text: 'Dodawanie zajęć'));

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('class-images/${newClass.id}/class-picture.jpg');
    final image = File(newClass.picture);
    await storageRef.putFile(image).then((p0) async {
      await FirebaseStorage.instance
          .ref()
          .child('class-images/${newClass.id}/class-picture.jpg')
          .getDownloadURL()
          .then((value) async {
        newClass.picture = value;
      });
    }, onError: (e) {
      showFailure = true;
    }).onError((error, stackTrace) {
      showFailure = true;
    });

    await ClassRepository.create(newClass).onError((error, stackTrace) async {
      await FirebaseStorage.instance
          .ref()
          .child('class-images/${newClass.id}/class-picture.jpg')
          .delete();
      newClass.picture =
          Class.fromMap(GetStorage().read('saved-class')).picture;

      showFailure = true;
    });

    if (showFailure == true) {
      _onFailure();
      return;
    }

    if (!mounted) return;
    context.read<ClassesBloc>().add(GetClasses());
    _onSuccess();
  }

  _onSuccess() {
    final rootContext = context;
    final role = rootContext.read<UserBloc>().state.user!.role;

    Navigator.of(rootContext, rootNavigator: true).pop();
    Navigator.of(rootContext, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ConfirmScreen(
          icon: Icons.auto_awesome_outlined,
          title: 'Gratulacje!',
          text: 'Zajęcia dodane pomyślnie',
          widgets: [
            ElevatedButton(
              style: CustomButtonStyle.primary,
              onPressed: () {
                //TODO nawigacja do zajęć
              },
              child: const Text('ZOBACZ TWOJE ZAJĘCIA'),
            ),
            ElevatedButton(
              style: CustomButtonStyle.secondary,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                    role == Role.teacher
                        ? MainPageTeacher.id
                        : MainPageStudent.id);
              },
              child: const Text('DODAJ KOLEJNE ZAJĘCIA'),
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
                Navigator.of(context).pop();
              },
              style: CustomButtonStyle.primary,
              child: const Text('POWRÓT DO PODSUMOWANIA'),
            ),
            title: 'Coś poszło nie tak...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Podsumowanie', appBar: AppBar()),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              ClassFieldWithLabel(
                label: 'Dodajesz zajęcia jako',
                height: 100,
                widget: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    final teacher = state.user!;
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 20.0),
                          child: UserPicture(radius: 40),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Text(
                                teacher.fullName,
                                style: const TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                teacher.email,
                                style: const TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: CustomColors.hintText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'instruktor',
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  color: CustomColors.text2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ClassFieldWithLabel(
                label: 'Nazwa zajęć',
                widget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.newClass.name,
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
              ),
              ClassFieldWithLabel(
                label: 'Wybrana data',
                widget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('dd.MM.yyyy').format(widget.newClass.date),
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
              ),
              ClassFieldWithLabel(
                label: 'Wybrana godzina',
                widget: Row(
                  children: [
                    Wrap(
                      spacing: 25,
                      children: [
                        const Text(
                          'od',
                          style: TextStyle(
                            color: CustomColors.hintText,
                            fontSize: 16,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          widget.newClass.hourSince,
                          style: const TextStyle(
                            color: CustomColors.text2,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.15),
                      child: Wrap(
                        spacing: 25,
                        children: [
                          const Text(
                            'do',
                            style: TextStyle(
                              color: CustomColors.hintText,
                              fontSize: 16,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.newClass.hourTo,
                            style: const TextStyle(
                              color: CustomColors.text2,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Satoshi',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ClassFieldWithLabel(
                label: 'Wybrany poziom',
                widget: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.newClass.level.description,
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
              ),
              ClassFieldWithLabel(
                label: 'Opis zajęć',
                height: null,
                widget: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.newClass.description,
                      style: const TextStyle(
                        color: CustomColors.inputText,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ),
              ),
              ClassFieldWithLabel(
                  label: 'Wybrane zdjęcie',
                  height: null,
                  widget: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(widget.newClass.picture),
                      width: 300,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.network(
                        widget.newClass.picture,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Text('Nieprawidłowe zdjęcie'),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 15.0,
                ),
                child: ElevatedButton(
                  onPressed: _submit,
                  style: CustomButtonStyle.primary,
                  child: const Text('DODAJ ZAJĘCIA'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  bottom: 30.0,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: CustomButtonStyle.secondaryTransparent,
                  child: const Text('ANULUJ'),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
