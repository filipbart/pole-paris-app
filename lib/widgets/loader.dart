import 'dart:ui';

import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class LoadingDialog extends StatelessWidget {
  final String text;
  const LoadingDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(90),
          child: SizedBox(
            height: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: CurvedCircularProgressIndicator.adaptive(
                    backgroundColor: Colors.transparent,
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation(CustomColors.text2),
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: CustomColors.buttonAdditional,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
