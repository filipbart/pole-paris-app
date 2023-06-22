import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/screens/teacher/class_students.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/app_bar.dart';
import 'package:pole_paris_app/widgets/teacher/class_base_info.dart';

class ClassDetailsScreen extends StatelessWidget {
  final bool forStudent;
  final Class classDetails;
  const ClassDetailsScreen(
      {super.key, required this.classDetails, required this.forStudent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Szczegóły zajęć',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClassBaseInfo(classDetails: classDetails),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.group_outlined,
                                      color: CustomColors.inputText,
                                    ),
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: CustomColors.inputText,
                                        fontFamily: 'Satoshi',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '7/10',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: ' miejsc'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (forStudent)
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.person_2_outlined,
                                        color: CustomColors.inputText,
                                      ),
                                    ),
                                    Text(
                                      'Anna Kowalska',
                                      style: TextStyle(
                                        color: CustomColors.inputText,
                                        fontFamily: 'Satoshi',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.place_outlined,
                                      color: CustomColors.inputText,
                                    ),
                                  ),
                                  Text(
                                    'Świdnik',
                                    style: TextStyle(
                                      color: CustomColors.inputText,
                                      fontFamily: 'Satoshi',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Opis zajęć',
                          style: TextStyle(
                            color: CustomColors.inputText,
                            fontFamily: 'Satoshi',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc congue gravida augue, a sagittis quam dapibus in. Morbi sodales consequat tempor. Nulla nec nisi in metus vehicula condimentum. Cras pretium ex arcu, bibendum efficitur lectus dignissim congue. In sit amet orci ac neque maximus suscipit. Mauris tempus nisi ante, ac eleifend libero aliquet non. Morbi ligula nisl, posuere vitae malesuada quis, rutrum non nisl. Donec dapibus ex velit. Suspendisse suscipit aliquam consequat. Duis vulputate ligula enim, in auctor metus feugiat a. Phasellus sit amet nulla id felis vulputate porta id a nisl. Praesent aliquam vestibulum viverra. In dapibus enim quis tellus aliquam, eget gravida lorem consequat.''',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Wrap(
                  runSpacing: 15,
                  children: [
                    if (forStudent) ...[
                      ElevatedButton(
                          onPressed: () {},
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => )),
                          style: CustomButtonStyle.primary,
                          child: const Text('WYPISZ SIĘ')),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: CustomButtonStyle.secondaryTransparent,
                          child: const Text('POWRÓT')),
                    ] else ...[
                      ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassStudentsScreen(
                                      classDetails: classDetails))),
                          style: CustomButtonStyle.primary,
                          child: const Text('LISTA KURSANTÓW')),
                      ElevatedButton(
                          onPressed: () {},
                          style: CustomButtonStyle.secondaryTransparent,
                          child: const Text('EDYTUJ')),
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
