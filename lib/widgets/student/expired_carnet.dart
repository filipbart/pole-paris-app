import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/user_carnet.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/utils/membership_helper.dart';

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
        border: Border.all(color: CustomColors.hintText),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 130,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    expiredCarnet.membership.name,
                    style: const TextStyle(
                      color: CustomColors.text3,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    MembershipHelper.entriesText(expiredCarnet.membership),
                    style: const TextStyle(
                      color: CustomColors.text3,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Ważny przez ${expiredCarnet.membership.validDays} dni od dnia zakupu',
                      style: const TextStyle(
                        color: CustomColors.text3,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
