import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class CustomButtonStyle {
  static ButtonStyle primary = ButtonStyle(
    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.text;
      },
    ),
    overlayColor: const MaterialStatePropertyAll<Color>(CustomColors.text2),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    )),
    textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Satoshi',
    )),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size.fromHeight(50),
    ),
  );

  static ButtonStyle secondary = ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.text;
      },
    ),
    overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    )),
    side: MaterialStateProperty.resolveWith<BorderSide>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(
            width: 2.0,
            color: CustomColors.text2,
          );
        }
        return const BorderSide(
          width: 2.0,
          color: CustomColors.text,
        );
      },
    ),
    textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Satoshi',
    )),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size.fromHeight(50),
    ),
  );

  static ButtonStyle additional = ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.buttonAdditional;
      },
    ),
    overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    )),
    side: MaterialStateProperty.resolveWith<BorderSide>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(
            width: 1.0,
            color: CustomColors.text2,
          );
        }
        return const BorderSide(
          width: 1.0,
          color: CustomColors.buttonAdditional,
        );
      },
    ),
    textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Satoshi',
    )),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size.fromHeight(50),
    ),
  );
}
