import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
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
    shadowColor: const MaterialStatePropertyAll<Color>(Colors.white),
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
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

  static ButtonStyle primaryWithoutSize = ButtonStyle(
    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.text;
      },
    ),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(58.0),
    )),
    textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Satoshi',
    )),
  );

  static ButtonStyle secondaryWithoutSize = ButtonStyle(
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
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
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
  );

  static ButtonStyle seeMore = ButtonStyle(
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF222227)),
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    overlayColor: const MaterialStatePropertyAll<Color>(CustomColors.text2),
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
    elevation: const MaterialStatePropertyAll<double>(2),
    shadowColor: const MaterialStatePropertyAll<Color>(Color(0xFF222227)),
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

  static ButtonStyle secondaryTransparent = ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.hintText;
      },
    ),
    overlayColor:
        const MaterialStatePropertyAll<Color>(CustomColors.background),
    backgroundColor:
        const MaterialStatePropertyAll<Color>(CustomColors.background),
    surfaceTintColor:
        const MaterialStatePropertyAll<Color>(CustomColors.background),
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
          color: CustomColors.hintText,
        );
      },
    ),
    textStyle: MaterialStatePropertyAll<TextStyle>(GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    )),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size.fromHeight(50),
    ),
  );

  static ButtonStyle whiteProfiles = ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.inputText;
      },
    ),
    overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
    elevation: const MaterialStatePropertyAll<double>(2),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    )),
    textStyle: MaterialStatePropertyAll<TextStyle>(GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: CustomColors.inputText,
    )),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size.fromHeight(50),
    ),
  );

  static ButtonStyle whiteProfilesWithoutSize = ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return CustomColors.text2;
        }
        return CustomColors.inputText;
      },
    ),
    overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
    elevation: const MaterialStatePropertyAll<double>(2),
    shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24.0),
    )),
    textStyle: MaterialStatePropertyAll<TextStyle>(GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: CustomColors.inputText,
    )),
  );
}
