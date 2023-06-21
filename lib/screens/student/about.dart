import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/student/contact.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';
import 'package:pole_paris_app/widgets/logo.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Kontakt', appBar: AppBar()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: CustomPaint(
                    painter: RPSCustomPainter(),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Logo(
                            width: 100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'O nas',
                                style: TextStyle(
                                  color: CustomColors.inputText,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '''Witaj w Pole Paris studio! Nasze studio jest idealnym miejscem dla wszystkich, którzy pragną odkryć tajniki pole dance i cieszyć się jego niezliczonymi korzyściami.''',
                                  style: TextStyle(
                                    color: CustomColors.hintText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 40,
                  ),
                  child: Text(
                    'Instruktorzy',
                    style: TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildTeacherInfo(),
                _buildTeacherInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherInfo() => Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
              bottom: 15,
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    UserPicture(radius: 60),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Magdalena',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          color: CustomColors.hintText,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Satoshi',
                        ),
                        children: [
                          TextSpan(
                            text: 'Cześć! ',
                            style: TextStyle(
                              color: CustomColors.text2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Będąc instruktorką, priorytetem jest zapewnienie bezpieczeństwa moim uczniom. Przed każdymi zajęciami zawsze dbam o solidne rozgrzewki i stretching, aby uczestnicy byli odpowiednio przygotowani do intensywnych ćwiczeń. Podczas treningów kładę duży nacisk na poprawną technikę wykonania ruchów, kontrolę mięśniową i właściwą postawę ciała, aby uniknąć ewentualnych kontuzji.',
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
