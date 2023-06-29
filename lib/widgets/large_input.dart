import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class LargeInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hint;
  const LargeInput({
    super.key,
    this.validator,
    this.controller,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: TextInputType.text,
        maxLines: 6,
        cursorColor: const Color(0xFF838383),
        style: const TextStyle(
          fontSize: 16,
          color: CustomColors.inputText,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint!,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: CustomColors.hintText,
            fontWeight: FontWeight.w300,
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            color: CustomColors.error,
            fontWeight: FontWeight.w700,
            height: 0.9,
          ),
          errorMaxLines: 2,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: CustomColors.line,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: CustomColors.buttonAdditional,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColors.error, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: CustomColors.error, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
