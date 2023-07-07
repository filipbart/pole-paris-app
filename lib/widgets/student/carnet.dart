import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';

class UserCarnetWidget extends StatelessWidget {
  final UserCarnet carnet;
  final Function()? onPressed;
  const UserCarnetWidget({
    super.key,
    required this.carnet,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  carnet.membership.name,
                  style: const TextStyle(
                    color: CustomColors.text2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  carnet.poleEntries != -1
                      ? '${carnet.poleEntries} wejścia'
                      : 'Nielimitowane wejścia',
                  style: const TextStyle(
                    color: CustomColors.inputText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Ważny do ${DateFormat('dd.MM.yyyy').format(carnet.expirationDate)}',
                    style: const TextStyle(
                      color: CustomColors.hintText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (onPressed != null)
              ElevatedButton(
                onPressed: onPressed,
                style: CustomButtonStyle.primaryWithoutSize,
                child: const Text('UŻYJ'),
              ),
          ],
        ),
      ),
    );
  }
}
