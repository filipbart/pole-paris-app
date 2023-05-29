import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? hint;
  final String? errorText;
  final bool? obscure;
  const Input({
    super.key,
    this.onChanged,
    this.controller,
    this.hint,
    this.errorText,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        cursorColor: const Color(0xFF838383),
        obscureText: obscure!,
        style: const TextStyle(
          fontSize: 16,
          color: CustomColors.inputText,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hint!,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: CustomColors.hintText,
            fontWeight: FontWeight.w300,
          ),
          errorText: errorText,
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
              color: CustomColors.inputLine,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF595959),
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
