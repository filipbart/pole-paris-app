import 'package:flutter/material.dart';
import 'package:pole_paris_app/providers/tab_index.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/widgets/circle_avatar.dart';
import 'package:provider/provider.dart';

class TeacherDrawer extends StatelessWidget {
  const TeacherDrawer({super.key});

  static TextStyle titleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Satoshi',
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 30.0,
            right: 30.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD6D6D6),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      UserPicture(radius: 30),
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
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0xFFD6D6D6),
                        width: 1,
                      ))),
                      child: ListTile(
                          title: const Text('Dodaj zajęcia'),
                          titleTextStyle: titleStyle,
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<TabIndex>(context, listen: false)
                                .changeIndex(3);
                          }),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0xFFD6D6D6),
                        width: 1,
                      ))),
                      child: ListTile(
                        title: const Text('Twoje zajęcia'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0xFFD6D6D6),
                        width: 1,
                      ))),
                      child: ListTile(
                        title: const Text('Profil instruktora'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: Color(0xFFD6D6D6),
                        width: 1,
                      ))),
                      child: ListTile(
                        title: const Text('Ustawienia'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: CustomButtonStyle.secondaryWithoutSize,
                    child: const Text('WYLOGUJ'),
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
