import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/screens/teacher/class_details.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/styles/text.dart';

class ClassItem extends StatelessWidget {
  final Class classItem;
  final bool? withBorder;
  const ClassItem({super.key, required this.classItem, this.withBorder});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      openBuilder: (context, closedContainer) =>
          ClassDetailsTeacherScreen(classDetails: classItem),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: () => openContainer(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
              left: 40,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      classItem.hourSince,
                      style: CustomTextStyle.hourStyle,
                    ),
                    Text(
                      classItem.hourTo,
                      style: CustomTextStyle.hourStyle,
                    )
                  ],
                ),
                const VerticalDivider(
                  thickness: 1.5,
                  color: Color(0xFF838383),
                ),
                Wrap(
                  spacing: -3,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      classItem.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 3,
                      children: [
                        const Icon(
                          Icons.star_border_rounded,
                          color: CustomColors.text2,
                          size: 15,
                        ),
                        Text(
                          classItem.level.description,
                          style: const TextStyle(
                            color: CustomColors.text2,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
