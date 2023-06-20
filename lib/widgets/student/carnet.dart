import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';

class UserCarnet extends StatelessWidget {
  final Membership membership;
  const UserCarnet({
    super.key,
    required this.membership,
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
                  membership.description,
                  style: const TextStyle(
                    color: CustomColors.text2,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '4 wejścia',
                  style: TextStyle(
                    color: CustomColors.inputText,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Ważny do ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
                    style: const TextStyle(
                      color: CustomColors.hintText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: CustomButtonStyle.primaryWithoutSize,
              child: const Text('UŻYJ'),
            ),
          ],
        ),
      ),
    );
  }
}
