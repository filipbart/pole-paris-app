import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/pages/main_student.dart';
import 'package:pole_paris_app/screens/classes_list.dart';
import 'package:pole_paris_app/screens/confirm.dart';
import 'package:pole_paris_app/screens/teacher/class_details.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/base/loader.dart';
import 'package:pole_paris_app/widgets/base/picture_background_app_bar.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

class OptOutScreen extends StatefulWidget {
  final Class classDetails;
  const OptOutScreen({super.key, required this.classDetails});

  @override
  State<OptOutScreen> createState() => _OptOutScreenState();
}

class _OptOutScreenState extends State<OptOutScreen> {
  _submit() {
    showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                const LoadingDialog(text: 'Trwa wypisywanie'))
        .timeout(const Duration(seconds: 1), onTimeout: () {
      Navigator.of(context, rootNavigator: true).pop();

      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => ConfirmScreen(
            icon: Icons.celebration_rounded,
            title: 'Gratulacje!',
            text: 'Pomyślnie wypisano z zajęć.',
            widgets: [
              ElevatedButton(
                style: CustomButtonStyle.primary,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainPageStudent(),
                  ));

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ClassesListScreen(),
                    ),
                  );
                },
                child: const Text('TWOJE ZAJĘCIA'),
              ),
              ElevatedButton(
                style: CustomButtonStyle.secondary,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPageStudent(),
                    ),
                  );
                },
                child: const Text('STRONA GŁÓWNA'),
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
      extendBodyBehindAppBar: true,
      appBar: PictureBackgroundAppBar(
        title: 'Wypisywanie z zajęć',
        appBar: AppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/opt_out_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            'Czy na pewno chcesz się wypisać z zajęć?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Instruktor zostanie automatycznie powiadomiony',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE1E1E1),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 30,
                                  right: 30,
                                ),
                                child: ClassBaseInfo(
                                    classDetails: widget.classDetails),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, top: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.group_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        '10 miejsc',
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontFamily: 'Satoshi',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.person_2_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        'Anna Kowalska',
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                          Icons.place_outlined,
                                          color: CustomColors.inputText,
                                        ),
                                      ),
                                      Text(
                                        'Świdnik',
                                        style: dataStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _submit,
                              style: CustomButtonStyle.primary,
                              child: const Text('WYPISZ'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: CustomButtonStyle.secondary,
                                child: const Text('ANULUJ'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
