import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/membership.dart';
import 'package:pole_paris_app/screens/student/buy_carnet.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';

class BuyMembershipWidget extends StatelessWidget {
  final Membership membership;
  final Function()? onPressed;
  const BuyMembershipWidget({
    super.key,
    required this.membership,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    membership.name,
                    style: const TextStyle(
                      color: CustomColors.text2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    entriesText(membership),
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Ważny przez ${membership.validDays} dni od dnia zakupu',
                      style: const TextStyle(
                        color: CustomColors.hintText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                children: [
                  Text(
                    '${membership.price.toString()} PLN',
                    style: const TextStyle(
                      color: Color(0xFFEE90E4),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: CustomButtonStyle.primaryWithoutSize,
                    child: const Text('WYBIERZ'),
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
