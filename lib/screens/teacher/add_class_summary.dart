import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/teacher/add_class.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/loader.dart';
import 'package:pole_paris_app/widgets/teacher/class_field_label.dart';

class AddClassSummary extends StatefulWidget {
  final Class newClass;
  const AddClassSummary({super.key, required this.newClass});

  @override
  State<AddClassSummary> createState() => _AddClassSummaryState();
}

class _AddClassSummaryState extends State<AddClassSummary> {
  _submit() {
    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const LoadingDialog(text: 'Dodawanie zajęć'))
        .timeout(const Duration(seconds: 2), onTimeout: () {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ConfirmScreen(
            icon: Icons.celebration_rounded,
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddClassScreen(),
                    ),
                    ModalRoute.withName('/add-class'),
                  );
                },
                child: const Text('DODAJ KOLEJNE ZAJĘCIA'),
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
      appBar: BaseAppBar(title: 'Podsumowanie', appBar: AppBar()),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              const ClassFieldWithLabel(
                label: 'Dodajesz zajęcia jako',
                height: 100,
                widget: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 20.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://img.freepik.com/darmowe-zdjecie/wewnatrz-portret-atrakcyjnej-mlodej-europejki-o-rudej-kobiecie-z-piegowata-twarza-i-wlosami-w-biala-bluzke-jej-wyglad-i-postawa-wyrazajace-pewnosc-siebie_273609-493.jpg"),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Magdalena Kowalska',
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'magdalena@gmail.com',
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              color: CustomColors.hintText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
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
                    child: Image.file(File(widget.newClass.image.path),
                        width: 300,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Text('Nieprawidłowe zdjęcie'))),
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
