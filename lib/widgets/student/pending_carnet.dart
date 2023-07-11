import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';

class UserPendingCarnet extends StatelessWidget {
  final UserCarnet pendingCarnet;
  const UserPendingCarnet({
    super.key,
    required this.pendingCarnet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 130,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pendingCarnet.membership.name,
                    style: const TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    MembershipHelper.entriesText(pendingCarnet.membership),
                    style: const TextStyle(
                      color: CustomColors.inputText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Ważny przez ${pendingCarnet.membership.validDays} dni od dnia zakupu',
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
              child: Text(
                '${pendingCarnet.membership.price} PLN',
                style: const TextStyle(
                  color: Color(0xFF404040),
                  fontSize: 20,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
