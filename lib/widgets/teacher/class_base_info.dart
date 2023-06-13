import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/styles/text.dart';

class ClassBaseInfo extends StatelessWidget {
  final Class classDetails;
  const ClassBaseInfo({super.key, required this.classDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                classDetails.hourSince,
                style: CustomTextStyle.hourStyle,
              ),
              Text(
                classDetails.hourTo,
                style: CustomTextStyle.hourStyle,
              ),
            ],
          ),
          const VerticalDivider(
            width: 40,
            thickness: 1,
            color: Color(0xFFE1E1E1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd.MM.yyyy').format(classDetails.date),
                style: const TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Satoshi',
                ),
              ),
              Text(
                classDetails.name,
                style: const TextStyle(
                  color: Color(0xFF1B1B1B),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi',
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 3,
                children: [
                  const Icon(
                    Icons.star_border_rounded,
                    size: 15,
                  ),
                  Text(
                    classDetails.level.description,
                    style: const TextStyle(
                      color: Color(0xFF282828),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
