import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class ClassesItem extends StatelessWidget {
  const ClassesItem({super.key});

  static TextStyle hourStyle = const TextStyle(
    color: CustomColors.text2,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  '09:30',
                  style: hourStyle,
                ),
                Text(
                  '10:30',
                  style: hourStyle,
                )
              ],
            ),
            const VerticalDivider(
              thickness: 1.5,
              color: Color(0xFF838383),
            ),
            const Wrap(
              spacing: -3,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.vertical,
              children: [
                Text(
                  'HIGH HEELS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3,
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: CustomColors.text2,
                      size: 15,
                    ),
                    Text(
                      'początkujący',
                      style: TextStyle(
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
    );
  }
}
