import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/styles/color.dart';

class UserExpiredCarnet extends StatelessWidget {
  final UserCarnet expiredCarnet;
  const UserExpiredCarnet({
    super.key,
    required this.expiredCarnet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC4C4C4)),
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
                  expiredCarnet.membership.name,
                  style: const TextStyle(
                    color: CustomColors.hintText,
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
          ],
        ),
      ),
    );
  }
}
