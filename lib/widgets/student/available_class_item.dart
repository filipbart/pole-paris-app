import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/models/class.dart';
import 'package:pole_paris_app/models/levels.dart';
import 'package:pole_paris_app/screens/student/available_class_details.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:pole_paris_app/styles/text.dart';

class AvailableClassItem extends StatelessWidget {
  final Class classItem;
  const AvailableClassItem({super.key, required this.classItem});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, closedContainer) =>
          AvailableClassDetails(classDetails: classItem),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: () => openContainer(),
        child: Container(
          color: Colors.white,
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  left: 20.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/img/test.png'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        thickness: 1,
                        color: Color(0xFFE1E1E1),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              classItem.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_border_rounded,
                                    color: CustomColors.text2,
                                    size: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      classItem.level.description,
                                      style: const TextStyle(
                                        color: CustomColors.text2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              classItem.teacher.getFirstName,
                              style: const TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
