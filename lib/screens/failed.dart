import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class FailedScreen extends StatelessWidget {
  final Widget button;
  final String title;

  const FailedScreen({
    super.key,
    required this.button,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
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
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Icon(
                      Icons.highlight_off_rounded,
                      color: CustomColors.error,
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
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CustomColors.inputText,
                            fontWeight: FontWeight.w600,
                            fontSize: 32,
                          ),
                        ),
                        const Text(
                          'Spróbuj ponownie.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.6,
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
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: button,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
