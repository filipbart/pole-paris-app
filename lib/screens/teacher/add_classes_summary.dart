import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class AddClassSummary extends StatelessWidget {
  const AddClassSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'Podsumowanie',
            style: TextStyle(
              color: CustomColors.buttonAdditional,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const Border(
            bottom: BorderSide(
              width: 0.4,
              color: Color(0xFF838383),
            ),
          )),
    );
  }
}
