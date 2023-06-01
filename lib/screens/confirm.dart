import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class ConfirmScreen extends StatelessWidget {
  final List<Widget> widgets;
  final IconData icon;
  final String title;
  final String text;

  const ConfirmScreen({
    super.key,
    required this.widgets,
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(1.3, -0.7),
                colors: [
                  Color.fromRGBO(238, 145, 229, 0.7),
                  Color.fromRGBO(255, 255, 255, 0.5),
                ],
                radius: 0.4,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 45,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Icon(
                      icon,
                      color: CustomColors.text2,
                      size: 140,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 50.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: CustomColors.inputText,
                            fontWeight: FontWeight.w600,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CustomColors.hintText,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: widgets.length == 1 ? 0 : 15,
                          ),
                          child: widgets.first,
                        ),
                        widgets.length == 1 ? Container() : widgets.last
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 400,
              width: 50,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-1.5, 0.5),
                  colors: [
                    Color.fromRGBO(238, 145, 229, 0.7),
                    Color.fromRGBO(255, 255, 255, 0.5),
                  ],
                  radius: 1.6,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
