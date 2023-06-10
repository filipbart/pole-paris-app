import 'package:flutter/material.dart';
import 'package:pole_paris_app/screens/teacher/add_class.dart';

class ClassFieldWithLabel extends StatelessWidget {
  final String label;
  final Widget widget;
  final double? height;
  const ClassFieldWithLabel({
    super.key,
    required this.label,
    required this.widget,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Wrap(
        runSpacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              label,
              style: inputLabels,
            ),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Container(
              height: height,
              color: widget is ClipRRect ? null : Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
