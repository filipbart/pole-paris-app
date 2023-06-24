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
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 10,
                    right: 10,
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
                        thickness: 1,
                        color: Color(0xFFE1E1E1),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              classItem.teacher,
                              style: const TextStyle(
                                color: CustomColors.hintText,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
