import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/styles/button.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';

class UserCarnetWidget extends StatelessWidget {
  final UserCarnet carnet;
  final Function()? onPressed;
  final String? buttonText;
  const UserCarnetWidget({
    super.key,
    required this.carnet,
    this.onPressed,
    this.buttonText,
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
              flex: 3,
              child: Column(
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
                    MembershipHelper.entriesText(carnet.membership),
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Ważny przez ${carnet.membership.validDays} dni od dnia zakupu',
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
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${carnet.membership.price} PLN',
                    style: const TextStyle(
                      color: Color(0xFFEE90E4),
                      fontSize: 20,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (onPressed != null)
                    ElevatedButton(
                      onPressed: onPressed,
                      style: CustomButtonStyle.primaryWithoutSize,
                      child: Text(
                        buttonText ?? 'UŻYJ',
                        style: buttonText != null
                            ? TextStyle(
                                fontSize: 12.5,
                              )
                            : null,
                      ),
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
